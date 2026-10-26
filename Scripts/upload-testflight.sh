#!/usr/bin/env bash
# Archive Athlete and upload to App Store Connect (TestFlight).
# Requires paid Apple Developer team + ASC API key — see TESTFLIGHT.md.
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"

: "${DEVELOPMENT_TEAM:?Set DEVELOPMENT_TEAM to your paid Apple Team ID}"
: "${APP_STORE_CONNECT_KEY_ID:?Set APP_STORE_CONNECT_KEY_ID}"
: "${APP_STORE_CONNECT_ISSUER_ID:?Set APP_STORE_CONNECT_ISSUER_ID}"
: "${APP_STORE_CONNECT_API_KEY_PATH:?Set APP_STORE_CONNECT_API_KEY_PATH to the .p8 file}"

if [[ ! -f "$APP_STORE_CONNECT_API_KEY_PATH" ]]; then
  echo "API key not found: $APP_STORE_CONNECT_API_KEY_PATH" >&2
  exit 1
fi

if command -v xcodegen >/dev/null 2>&1; then
  xcodegen generate
fi

DERIVED="${DERIVED_DATA_PATH:-/tmp/AthleteTFDerived}"
ARCHIVE="$DERIVED/Athlete.xcarchive"
EXPORT_DIR="$DERIVED/export"
EXPORT_PLIST="$DERIVED/ExportOptions.plist"

rm -rf "$DERIVED"
mkdir -p "$DERIVED" "$EXPORT_DIR"

cat > "$EXPORT_PLIST" <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>method</key>
	<string>app-store-connect</string>
	<key>destination</key>
	<string>upload</string>
	<key>signingStyle</key>
	<string>automatic</string>
	<key>teamID</key>
	<string>${DEVELOPMENT_TEAM}</string>
	<key>uploadSymbols</key>
	<true/>
	<key>manageAppVersionAndBuildNumber</key>
	<true/>
</dict>
</plist>
EOF

echo "→ Archiving (Release)…"
xcodebuild archive \
  -project AthleteApp.xcodeproj \
  -scheme AthleteApp \
  -configuration Release \
  -destination "generic/platform=iOS" \
  -archivePath "$ARCHIVE" \
  -derivedDataPath "$DERIVED" \
  DEVELOPMENT_TEAM="$DEVELOPMENT_TEAM" \
  CODE_SIGN_STYLE=Automatic

echo "→ Uploading to App Store Connect…"
xcodebuild -exportArchive \
  -archivePath "$ARCHIVE" \
  -exportOptionsPlist "$EXPORT_PLIST" \
  -exportPath "$EXPORT_DIR" \
  -allowProvisioningUpdates \
  -authenticationKeyPath "$APP_STORE_CONNECT_API_KEY_PATH" \
  -authenticationKeyID "$APP_STORE_CONNECT_KEY_ID" \
  -authenticationKeyIssuerID "$APP_STORE_CONNECT_ISSUER_ID"

echo "✓ Upload finished. App Store Connect → Athlete → TestFlight (processing can take minutes)."
echo "  On iPhone: open TestFlight → install Athlete."
