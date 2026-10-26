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

In Xcode:

1. Select the **AthleteApp** scheme
2. Choose an iPhone simulator (or a device)
3. Press **Run** (⌘R)

### First-run flow

1. **Onboarding** — pick Athlete or Scout / Recruiter  
2. **Profile** — mock athlete profile (Jordan Okeke)  
3. **Discover** — search/filter soccer athletes, open detail  
4. **Connect** — send a connection request (local state)  
5. **Inbox** — stub threads + incoming request accept  

Use **Switch role** on Profile to return to onboarding.

## Project layout

```
AthleteApp/
  Models/          # Roles, athlete profiles, connections, messages
  Data/            # MockData + AppStore (in-memory state)
  Theme/           # Pitch-green athletic palette
  Navigation/      # Main tab shell
  Features/
    Onboarding/    # Role picker
    Profile/       # Own profile + detail
    Discovery/     # Feed / search
    Connect/       # Connection request
    Inbox/         # Threads + requests stub
```

## Typography

Bundled brand pairing (White & Case–inspired, not their proprietary faces):

- **Source Serif 4** — display / wordmark / stats
- **IBM Plex Sans** — UI body and chrome

Licenses ship under `AthleteApp/Fonts/`.

## Notes

- `AthleteApp.xcodeproj` is generated; prefer editing `project.yml` then re-running `xcodegen generate`.
- UI is light-mode, soccer-first, English only.
- Next step after this shell: real auth/backend (e.g. Supabase), media highlights, and verification.
