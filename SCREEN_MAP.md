# Athlete — Screen map (MVP)

Native SwiftUI, soccer-first. Athlete + Scout/Recruiter. Mock data only.

## Information architecture

### Tabs (role-aware shell)

| Tab | Athlete | Scout / Recruiter |
|-----|---------|-------------------|
| **Home** | Network activity feed | Pipeline: shortlist + recent activity |
| **Discover** | Search / filter athletes | Same (primary work surface) |
| **Inbox** | Requests + threads | Same |
| **Profile** | Own athlete profile | Own scout identity + prefs |

### Full screen inventory

| # | Screen | Status | Notes |
|---|--------|--------|-------|
| 1 | Role onboarding | Built | Brand cobalt; Athlete vs Scout |
| 2 | Home (activity / pipeline) | **New** | Role-specific landing |
| 3 | Discover (search + filters) | Built | Position / level filters |
| 4 | Athlete profile detail | Built | Stats, achievements, Connect CTA |
| 5 | Connect request | Built | Note + send |
| 6 | Inbox | Built | Requests + threads |
| 7 | Thread detail | Built | Local reply stub |
| 8 | Own athlete profile | Built | Switch role |
| 9 | Edit profile | **New** | Mock save |
| 10 | Connections | **New** | From profile / home |
| 11 | Shortlist (saved) | **New** | Scout-focused; athletes can open |
| 12 | Notifications | **New** | Quiet list |
| 13 | Settings | **New** | Role, account stubs |
| 14 | Highlight detail | **New** | Placeholder media row → detail |
| 15 | Scout profile (own) | **New** | Shown on Profile tab for scouts |

### Out of scope (later)

Verification flows, payments, media upload, real auth, club/coach distinct IA, Android/web.

## Primary user journeys

1. **Athlete onboarding** → Home → polish Profile / Edit → Discover peers → Connect → Inbox  
2. **Scout onboarding** → Pipeline Home → Discover → Profile detail → Connect / Shortlist → Inbox  
3. **Either role** → Notifications / Settings from Profile or toolbar  

## Navigation rules

- Profile detail is the hub for Connect, Shortlist toggle, and Highlights.  
- Connections and Shortlist are plain lists (editorial, no card stacks).  
- Settings always available from Profile toolbar.
