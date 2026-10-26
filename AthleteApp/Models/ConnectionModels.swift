import Foundation

enum ConnectionStatus: String, Codable, Hashable {
    case none
    case pendingOutgoing
    case pendingIncoming
    case connected
}

struct ConnectionRequest: Identifiable, Hashable, Codable {
    let id: UUID
    let fromUserName: String
    let toAthleteId: UUID
    let toAthleteName: String
    var message: String
    var status: ConnectionStatus
    let createdAt: Date
}

struct MessageThread: Identifiable, Hashable, Codable {
    let id: UUID
    var participantName: String
    var participantRole: UserRole
    var athleteId: UUID?
    var preview: String
    var updatedAt: Date
    var unreadCount: Int
    var messages: [ChatMessage]
}

struct ChatMessage: Identifiable, Hashable, Codable {
    let id: UUID
    var senderName: String
    var body: String
    var sentAt: Date
    var isFromCurrentUser: Bool
}
