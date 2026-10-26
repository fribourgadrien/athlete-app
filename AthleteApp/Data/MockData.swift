import Foundation

enum MockData {
    static let currentAthleteID = UUID(uuidString: "A1111111-1111-1111-1111-111111111111")!
    static let scoutName = "Elena Vargas"

    static let athletes: [AthleteProfile] = [
        AthleteProfile(
            id: currentAthleteID,
            fullName: "Jordan Okeke",
            displayName: "J. Okeke",
            position: .attackingMid,
            club: "Harbor FC Academy",
            level: .academy,
            location: "Lisbon, Portugal",
            nationality: "Nigeria",
            age: 19,
            heightCm: 178,
            preferredFoot: .right,
            bio: "Creative midfielder who unlocks compact blocks with progressive carries and late box arrivals. Captained U19s last season.",
            stats: PlayerStats(appearances: 24, goals: 9, assists: 11, cleanSheets: nil),
            achievements: [
                "U19 Regional Cup winner 2025",
                "Academy Player of the Month — March",
                "National youth camp call-up"
            ],
            highlightTitles: [
                "Assist vs Norte United",
                "Solo goal — Regional Final",
                "Training clip: weak-foot finishing"
            ],
            lookingFor: ["College soccer pathway", "Trial opportunities", "Mentorship"],
            connectionCount: 48
        ),
        AthleteProfile(
            id: UUID(uuidString: "A2222222-2222-2222-2222-222222222222")!,
            fullName: "Maya Chen",
            displayName: "M. Chen",
            position: .winger,
            club: "Pacific United Women",
            level: .semiPro,
            location: "Vancouver, Canada",
            nationality: "Canada",
            age: 22,
            heightCm: 165,
            preferredFoot: .left,
            bio: "Direct winger with elite 1v1 pace. Strong crossing under pressure and high pressing work rate.",
            stats: PlayerStats(appearances: 31, goals: 12, assists: 14, cleanSheets: nil),
            achievements: [
                "League assist leader 2025",
                "National B team training camp"
            ],
            highlightTitles: [
                "Hat-trick of assists — Derby",
                "Recovery sprint & finish"
            ],
            lookingFor: ["Pro contract abroad", "Exposure to European scouts"],
            connectionCount: 112
        ),
        AthleteProfile(
            id: UUID(uuidString: "A3333333-3333-3333-3333-333333333333")!,
            fullName: "Lucas Ferreira",
            displayName: "L. Ferreira",
            position: .centerBack,
            club: "São Paulo State U20",
            level: .academy,
            location: "Campinas, Brazil",
            nationality: "Brazil",
            age: 18,
            heightCm: 188,
            preferredFoot: .right,
            bio: "Left-sided center back comfortable building from the back. Aerial dominance and calm under press.",
            stats: PlayerStats(appearances: 19, goals: 2, assists: 1, cleanSheets: 8),
            achievements: [
                "State championship finalist",
                "Clean sheet streak — 5 matches"
            ],
            highlightTitles: [
                "Last-man tackle vs rivals",
                "Progressive line-breaking pass"
            ],
            lookingFor: ["European academy trial", "Scout feedback"],
            connectionCount: 67
        ),
        AthleteProfile(
            id: UUID(uuidString: "A4444444-4444-4444-4444-444444444444")!,
            fullName: "Sofia Alvarez",
            displayName: "S. Alvarez",
            position: .striker,
            club: "Madrid Norte CF",
            level: .collegiate,
            location: "Madrid, Spain",
            nationality: "Spain",
            age: 20,
            heightCm: 172,
            preferredFoot: .both,
            bio: "Movement striker who thrives between lines. Clinical from both feet inside the box.",
            stats: PlayerStats(appearances: 22, goals: 17, assists: 4, cleanSheets: nil),
            achievements: [
                "Campus league golden boot",
                "Regional all-star selection"
            ],
            highlightTitles: [
                "Brace vs Atlético youth",
                "Hold-up & link play reel"
            ],
            lookingFor: ["NCAA / pro pathway", "Highlight review"],
            connectionCount: 89
        ),
        AthleteProfile(
            id: UUID(uuidString: "A5555555-5555-5555-5555-555555555555")!,
            fullName: "Amir Hassan",
            displayName: "A. Hassan",
            position: .goalkeeper,
            club: "Cairo Stars",
            level: .professional,
            location: "Cairo, Egypt",
            nationality: "Egypt",
            age: 24,
            heightCm: 191,
            preferredFoot: .right,
            bio: "Shot-stopping keeper with strong distribution. Experienced in high-tempo leagues and continental cups.",
            stats: PlayerStats(appearances: 28, goals: 0, assists: 0, cleanSheets: 11),
            achievements: [
                "Domestic cup finalist",
                "Club player of the season nominee"
            ],
            highlightTitles: [
                "Penalty save — cup semi",
                "Distribution under press"
            ],
            lookingFor: ["European club interest", "Agent introductions"],
            connectionCount: 203
        ),
        AthleteProfile(
            id: UUID(uuidString: "A6666666-6666-6666-6666-666666666666")!,
            fullName: "Nora Bergström",
            displayName: "N. Bergström",
            position: .defensiveMid,
            club: "Stockholm IF",
            level: .semiPro,
            location: "Stockholm, Sweden",
            nationality: "Sweden",
            age: 23,
            heightCm: 170,
            preferredFoot: .right,
            bio: "Anchor midfielder with elite recoveries and tempo control. Quiet leader who organizes the press.",
            stats: PlayerStats(appearances: 26, goals: 3, assists: 6, cleanSheets: nil),
            achievements: [
                "Team captain 2025",
                "Most interceptions — league phase"
            ],
            highlightTitles: [
                "Interception → transition goal",
                "Set-piece delivery reel"
            ],
            lookingFor: ["Top-flight move", "National team pathway"],
            connectionCount: 94
        )
    ]

    static var currentAthlete: AthleteProfile {
        athletes.first { $0.id == currentAthleteID }!
    }

    static let sampleThreads: [MessageThread] = [
        MessageThread(
            id: UUID(uuidString: "T1111111-1111-1111-1111-111111111111")!,
            participantName: "Elena Vargas",
            participantRole: .scout,
            athleteId: currentAthleteID,
            preview: "Impressed by your Regional Final clip — open to a call?",
            updatedAt: Date().addingTimeInterval(-3600),
            unreadCount: 1,
            messages: [
                ChatMessage(
                    id: UUID(),
                    senderName: "Elena Vargas",
                    body: "Hi Jordan — I cover Iberian academies for Atlantic Scouting. Impressed by your Regional Final clip.",
                    sentAt: Date().addingTimeInterval(-7200),
                    isFromCurrentUser: false
                ),
                ChatMessage(
                    id: UUID(),
                    senderName: "Elena Vargas",
                    body: "Would you be open to a short call this week?",
                    sentAt: Date().addingTimeInterval(-3600),
                    isFromCurrentUser: false
                )
            ]
        ),
        MessageThread(
            id: UUID(uuidString: "T2222222-2222-2222-2222-222222222222")!,
            participantName: "Maya Chen",
            participantRole: .athlete,
            athleteId: UUID(uuidString: "A2222222-2222-2222-2222-222222222222")!,
            preview: "Nice assist numbers this season — keep going.",
            updatedAt: Date().addingTimeInterval(-86400),
            unreadCount: 0,
            messages: [
                ChatMessage(
                    id: UUID(),
                    senderName: "Jordan Okeke",
                    body: "Watched your derby highlights — elite crossing.",
                    sentAt: Date().addingTimeInterval(-90000),
                    isFromCurrentUser: true
                ),
                ChatMessage(
                    id: UUID(),
                    senderName: "Maya Chen",
                    body: "Nice assist numbers this season — keep going.",
                    sentAt: Date().addingTimeInterval(-86400),
                    isFromCurrentUser: false
                )
            ]
        )
    ]

    static let sampleIncomingRequest = ConnectionRequest(
        id: UUID(uuidString: "C1111111-1111-1111-1111-111111111111")!,
        fromUserName: "Elena Vargas",
        toAthleteId: currentAthleteID,
        toAthleteName: "Jordan Okeke",
        message: "I'd like to connect about academy pathways into Northern Europe.",
        status: .pendingIncoming,
        createdAt: Date().addingTimeInterval(-18000)
    )
}
