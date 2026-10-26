import Foundation

extension MockData {
    static let currentScoutID = UUID(uuidString: "E1111111-1111-1111-1111-111111111111")!

    static let scout = ScoutProfile(
        id: currentScoutID,
        fullName: "Elena Vargas",
        organization: "Atlantic Scouting",
        title: "Iberian Academies Scout",
        location: "Madrid, Spain",
        focus: "Attacking midfielders & wide forwards, U18–U23",
        bio: "Covers academy and semi-pro pathways across Iberia and LatAm. Prioritizes progressive midfielders with decision speed under press.",
        regions: ["Iberia", "LatAm", "Northern Europe pathways"]
    )

    static let highlights: [HighlightClip] = [
        HighlightClip(
            id: UUID(uuidString: "D1111111-1111-1111-1111-111111111111")!,
            athleteId: currentAthleteID,
            athleteName: "Jordan Okeke",
            title: "Assist vs Norte United",
            caption: "Attacking Mid · Harbor FC Academy",
            durationLabel: "0:24"
        ),
        HighlightClip(
            id: UUID(uuidString: "D2222222-2222-2222-2222-222222222222")!,
            athleteId: currentAthleteID,
            athleteName: "Jordan Okeke",
            title: "Solo goal — Regional Final",
            caption: "Attacking Mid · Harbor FC Academy",
            durationLabel: "0:31"
        ),
        HighlightClip(
            id: UUID(uuidString: "D3333333-3333-3333-3333-333333333333")!,
            athleteId: UUID(uuidString: "A2222222-2222-2222-2222-222222222222")!,
            athleteName: "Maya Chen",
            title: "Hat-trick of assists — Derby",
            caption: "Winger · Pacific United Women",
            durationLabel: "1:02"
        ),
        HighlightClip(
            id: UUID(uuidString: "D4444444-4444-4444-4444-444444444444")!,
            athleteId: UUID(uuidString: "A3333333-3333-3333-3333-333333333333")!,
            athleteName: "Lucas Ferreira",
            title: "Last-man tackle vs rivals",
            caption: "Center Back · São Paulo State U20",
            durationLabel: "0:18"
        ),
        HighlightClip(
            id: UUID(uuidString: "D5555555-5555-5555-5555-555555555555")!,
            athleteId: UUID(uuidString: "A4444444-4444-4444-4444-444444444444")!,
            athleteName: "Sofia Alvarez",
            title: "Brace vs Atlético youth",
            caption: "Striker · Madrid Norte CF",
            durationLabel: "0:44"
        )
    ]

    static let activity: [ActivityItem] = [
        ActivityItem(
            id: UUID(uuidString: "F1111111-1111-1111-1111-111111111111")!,
            kind: .highlight,
            title: "Maya Chen posted a highlight",
            subtitle: "Hat-trick of assists — Derby",
            timestamp: Date().addingTimeInterval(-2 * 3600),
            relatedAthleteId: UUID(uuidString: "A2222222-2222-2222-2222-222222222222")!
        ),
        ActivityItem(
            id: UUID(uuidString: "F2222222-2222-2222-2222-222222222222")!,
            kind: .connection,
            title: "You connected with Maya Chen",
            subtitle: "Pacific United Women · Winger",
            timestamp: Date().addingTimeInterval(-26 * 3600),
            relatedAthleteId: UUID(uuidString: "A2222222-2222-2222-2222-222222222222")!
        ),
        ActivityItem(
            id: UUID(uuidString: "F3333333-3333-3333-3333-333333333333")!,
            kind: .request,
            title: "Elena Vargas sent a connection request",
            subtitle: "Atlantic Scouting · Iberian Academies",
            timestamp: Date().addingTimeInterval(-5 * 3600),
            relatedAthleteId: currentAthleteID
        ),
        ActivityItem(
            id: UUID(uuidString: "F4444444-4444-4444-4444-444444444444")!,
            kind: .highlight,
            title: "Lucas Ferreira posted a highlight",
            subtitle: "Last-man tackle vs rivals",
            timestamp: Date().addingTimeInterval(-48 * 3600),
            relatedAthleteId: UUID(uuidString: "A3333333-3333-3333-3333-333333333333")!
        ),
        ActivityItem(
            id: UUID(uuidString: "F5555555-5555-5555-5555-555555555555")!,
            kind: .shortlist,
            title: "Sofia Alvarez added to shortlist",
            subtitle: "Madrid Norte CF · Striker",
            timestamp: Date().addingTimeInterval(-72 * 3600),
            relatedAthleteId: UUID(uuidString: "A4444444-4444-4444-4444-444444444444")!
        )
    ]

    static let notifications: [AppNotification] = [
        AppNotification(
            id: UUID(uuidString: "C1111111-1111-1111-1111-111111111101")!,
            title: "New connection request",
            body: "Elena Vargas wants to connect about academy pathways.",
            timestamp: Date().addingTimeInterval(-5 * 3600),
            isRead: false
        ),
        AppNotification(
            id: UUID(uuidString: "C2222222-2222-2222-2222-222222222202")!,
            title: "Message from Elena Vargas",
            body: "Would you be open to a short call this week?",
            timestamp: Date().addingTimeInterval(-3600),
            isRead: false
        ),
        AppNotification(
            id: UUID(uuidString: "C3333333-3333-3333-3333-333333333303")!,
            title: "Profile viewed",
            body: "A scout at Atlantic Scouting viewed your profile.",
            timestamp: Date().addingTimeInterval(-20 * 3600),
            isRead: true
        ),
        AppNotification(
            id: UUID(uuidString: "C4444444-4444-4444-4444-444444444404")!,
            title: "Maya Chen accepted your note",
            body: "You’re connected — start a conversation in Inbox.",
            timestamp: Date().addingTimeInterval(-30 * 3600),
            isRead: true
        )
    ]

    static let defaultShortlistIDs: [UUID] = [
        UUID(uuidString: "A4444444-4444-4444-4444-444444444444")!,
        UUID(uuidString: "A3333333-3333-3333-3333-333333333333")!,
        UUID(uuidString: "A5555555-5555-5555-5555-555555555555")!
    ]
}
