import Foundation

struct AthleteProfile: Identifiable, Hashable, Codable {
    let id: UUID
    var fullName: String
    var displayName: String
    var position: SoccerPosition
    var club: String
    var level: CompetitiveLevel
    var location: String
    var nationality: String
    var age: Int
    var heightCm: Int
    var preferredFoot: PreferredFoot
    var bio: String
    var stats: PlayerStats
    var achievements: [String]
    var highlightTitles: [String]
    var lookingFor: [String]
    var connectionCount: Int

    var initials: String {
        let parts = fullName.split(separator: " ")
        let letters = parts.prefix(2).compactMap { $0.first }
        return String(letters).uppercased()
    }
}

enum SoccerPosition: String, CaseIterable, Identifiable, Codable, Hashable {
    case goalkeeper = "GK"
    case centerBack = "CB"
    case fullBack = "FB"
    case defensiveMid = "CDM"
    case centralMid = "CM"
    case attackingMid = "CAM"
    case winger = "W"
    case striker = "ST"

    var id: String { rawValue }

    var label: String {
        switch self {
        case .goalkeeper: return "Goalkeeper"
        case .centerBack: return "Center Back"
        case .fullBack: return "Full Back"
        case .defensiveMid: return "Defensive Mid"
        case .centralMid: return "Central Mid"
        case .attackingMid: return "Attacking Mid"
        case .winger: return "Winger"
        case .striker: return "Striker"
        }
    }
}

enum CompetitiveLevel: String, CaseIterable, Identifiable, Codable, Hashable {
    case academy = "Academy"
    case collegiate = "Collegiate"
    case semiPro = "Semi-Pro"
    case professional = "Professional"

    var id: String { rawValue }
}

enum PreferredFoot: String, Codable, Hashable {
    case left = "Left"
    case right = "Right"
    case both = "Both"
}

struct PlayerStats: Hashable, Codable {
    var appearances: Int
    var goals: Int
    var assists: Int
    var cleanSheets: Int?
}
