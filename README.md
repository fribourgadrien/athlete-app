# Athlete

Native **SwiftUI** iOS MVP for a LinkedIn-style network for athletes and scouts — soccer/football first.

Local mock data only. No backend, verification, or payments in this scaffold.

## Requirements

- macOS with **Xcode 16+** (iOS 17 deployment target)
- [XcodeGen](https://github.com/yonaskolb/XcodeGen) (`brew install xcodegen`) to regenerate the `.xcodeproj` from `project.yml`

## Open & run

```bash
cd athlete-app
xcodegen generate
open AthleteApp.xcodeproj
```

In Xcode: select **AthleteApp** → iPhone simulator → Run (⌘R).

### First-run flow

1. **Onboarding** — Athlete or Scout / Recruiter  
2. **Home / Pipeline** — activity feed (athlete) or shortlist pipeline (scout)  
3. **Discover** — search/filter → profile detail → Connect / Save  
4. **Inbox** — requests + threads  
5. **Profile** — own athlete or scout identity, Edit, Settings  

See [SCREEN_MAP.md](SCREEN_MAP.md) for the full inventory.

## Tabs

| Tab | Athlete | Scout |
|-----|---------|-------|
| Home | Network activity | Pipeline + shortlist |
| Discover | Search athletes | Same |
| Inbox | Requests + messages | Same |
| Profile | Athlete profile | Scout profile |

## Project layout

```
AthleteApp/
  Models/          # Profiles, connections, activity, notifications
  Data/            # MockData + AppStore
  Theme/           # Cobalt + Source Serif 4 / IBM Plex Sans
  Navigation/      # 4-tab shell
  Features/
    Onboarding/
    Home/          # Activity, notifications
    Discovery/
    Connect/
    Inbox/
    Network/       # Connections, shortlist
    Profile/       # Own profiles, edit, settings, highlights
```

## Typography

- **Source Serif 4** — display / wordmark / stats  
- **IBM Plex Sans** — UI body and chrome  

Licenses under `AthleteApp/Fonts/`.

## TestFlight

See [TESTFLIGHT.md](TESTFLIGHT.md). Requires a paid Apple Developer Program membership.

## Notes

- Prefer editing `project.yml` then `xcodegen generate`.
- Light mode, English, soccer-first. Next: auth/backend, real media, verification.
