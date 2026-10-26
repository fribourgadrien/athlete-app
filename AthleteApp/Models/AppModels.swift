import Foundation

struct ScoutProfile: Identifiable, Hashable, Codable {
    let id: UUID
    var fullName: String
    var organization: String
    var title: String
    var location: String
    var focus: String
    var bio: String
    var regions: [String]

    var initials: String {
        String(fullName.split(separator: " ").compactMap(\.first).prefix(2)).uppercased()
    }

    var displayName: String {
        let parts = fullName.split(separator: " ")
        guard let first = parts.first, let last = parts.last, parts.count > 1 else {
            return fullName
        }
        return "\(first.prefix(1)). \(last)"
    }
}

struct HighlightClip: Identifiable, Hashable, Codable {
    let id: UUID
    var athleteId: UUID
    var athleteName: String
    var title: String
    var caption: String
    var durationLabel: String
}

enum ActivityKind: String, Codable, Hashable {
    case connection
    case highlight
    case shortlist
    case request
}

struct ActivityItem: Identifiable, Hashable, Codable {
    let id: UUID
    var kind: ActivityKind
    var title: String
    var subtitle: String
    var timestamp: Date
    var relatedAthleteId: UUID?
}

struct AppNotification: Identifiable, Hashable, Codable {
    let id: UUID
    var title: String
    var body: String
    var timestamp: Date
    var isRead: Bool
}
