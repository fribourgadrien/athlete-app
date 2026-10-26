# TestFlight setup — Athlete

## Blocker (current Mac)

Xcode shows **Adrien Fribourg (Personal Team)** `LX3JUJXQZ6` as a **free** provisioning team.

**TestFlight requires an Apple Developer Program membership** ($99/year). Free Personal Teams can sideload to your own iPhone via Xcode, but **cannot** upload to App Store Connect / TestFlight.

Enroll here (use the Apple ID you want for Athlete):  
https://developer.apple.com/programs/enroll/

After enrollment is **Active** (can take up to ~48h), continue below.

---

## One-time App Store Connect setup

1. Open [App Store Connect](https://appstoreconnect.apple.com) → **My Apps** → **+** → **New App**
   - Platform: iOS  
   - Name: **Athlete**  
   - Bundle ID: register `com.adrienfribourg.athleteapp` in [Certificates, Identifiers & Profiles](https://developer.apple.com/account/resources/identifiers/list) first if needed  
   - SKU: e.g. `athlete-ios-001`  
   - Access: Full Access  

2. (Recommended for agents / CI) Create an **App Store Connect API key**  
   Users and Access → Integrations → App Store Connect API → **Generate**  
   Role: **App Manager** or **Admin**  
   Download the `.p8` once. Note **Issuer ID** and **Key ID**.

3. Add yourself (and testers) under the app → **TestFlight** → Internal Testing.

---

## Project settings (this repo)

| Setting | Value |
|--------|--------|
| Bundle ID | `com.adrienfribourg.athleteapp` |
| Display name | Athlete |
| Marketing version | `0.1.0` (bump as needed) |
| Build number | `CURRENT_PROJECT_VERSION` |

After you have a paid team ID, set it in `project.yml`:

```yaml
DEVELOPMENT_TEAM: YOUR_TEAM_ID
CODE_SIGN_STYLE: Automatic
```

Then run `xcodegen generate`.

---

## Archive & upload (on the Mac)

### Option A — Xcode UI

1. `cd ~/Desktop/athlete-app && xcodegen generate && open AthleteApp.xcodeproj`
2. Select target **AthleteApp** → Signing → Team = your **paid** team  
3. Destination: **Any iOS Device (arm64)**  
4. **Product → Archive**  
5. Organizer → **Distribute App** → **App Store Connect** → Upload  
6. App Store Connect → Athlete → TestFlight → wait for processing → add build to Internal group  
7. On iPhone: install **TestFlight**, accept invite, install **Athlete**

### Option B — CLI (after API key is on the Mac)

```bash
./Scripts/upload-testflight.sh
```

Place secrets as env vars (never commit):

```bash
export APP_STORE_CONNECT_API_KEY_PATH=~/.appstoreconnect/private_keys/AuthKey_XXXXXX.p8
export APP_STORE_CONNECT_KEY_ID=XXXXXX
export APP_STORE_CONNECT_ISSUER_ID=xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
export DEVELOPMENT_TEAM=YOUR_TEAM_ID
```

---

## App Icon

App Store / TestFlight uploads need a **1024×1024** App Icon in `Assets.xcassets/AppIcon`.  
Add one before the first upload if Xcode validation complains.

---

## Sideload without TestFlight (free team)

Until membership is active, use USB/wireless **Run** from Xcode to your iPhone (7-day cert refresh).
