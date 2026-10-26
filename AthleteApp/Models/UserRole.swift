import Foundation

enum UserRole: String, CaseIterable, Identifiable, Codable {
    case athlete
    case scout

    var id: String { rawValue }

    var title: String {
        switch self {
        case .athlete: return "Athlete"
        case .scout: return "Scout / Recruiter"
        }
    }

    var subtitle: String {
        switch self {
        case .athlete:
            return "Showcase your game, stats, and highlights to get discovered."
        case .scout:
            return "Find soccer talent, evaluate profiles, and connect directly."
        }
    }

    var systemImage: String {
        switch self {
        case .athlete: return "figure.soccer"
        case .scout: return "binoculars.fill"
        }
    }
}
