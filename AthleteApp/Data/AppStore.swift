import Foundation
import SwiftUI

@MainActor
final class AppStore: ObservableObject {
    @Published var selectedRole: UserRole?
    @Published var hasCompletedOnboarding = false
    @Published var athletes: [AthleteProfile]
    @Published var connectionStatuses: [UUID: ConnectionStatus]
    @Published var pendingRequests: [ConnectionRequest]
    @Published var threads: [MessageThread]
    @Published var searchText = ""
    @Published var selectedPosition: SoccerPosition?
    @Published var selectedLevel: CompetitiveLevel?
    @Published var toastMessage: String?

    init() {
        athletes = MockData.athletes
        connectionStatuses = [
            MockData.currentAthleteID: .connected,
            UUID(uuidString: "A2222222-2222-2222-2222-222222222222")!: .connected
        ]
        pendingRequests = [MockData.sampleIncomingRequest]
        threads = MockData.sampleThreads
    }

    var currentAthlete: AthleteProfile {
        athletes.first { $0.id == MockData.currentAthleteID } ?? MockData.currentAthlete
    }

    var filteredAthletes: [AthleteProfile] {
        athletes.filter { athlete in
            let matchesSearch: Bool = {
                guard !searchText.isEmpty else { return true }
                let q = searchText.lowercased()
                return athlete.fullName.lowercased().contains(q)
                    || athlete.club.lowercased().contains(q)
                    || athlete.location.lowercased().contains(q)
                    || athlete.position.label.lowercased().contains(q)
                    || athlete.position.rawValue.lowercased().contains(q)
            }()
            let matchesPosition = selectedPosition.map { athlete.position == $0 } ?? true
            let matchesLevel = selectedLevel.map { athlete.level == $0 } ?? true
            return matchesSearch && matchesPosition && matchesLevel
        }
    }

    func completeOnboarding(role: UserRole) {
        selectedRole = role
        withAnimation(.easeInOut(duration: 0.35)) {
            hasCompletedOnboarding = true
        }
    }

    func resetOnboarding() {
        hasCompletedOnboarding = false
        selectedRole = nil
    }

    func status(for athleteID: UUID) -> ConnectionStatus {
        connectionStatuses[athleteID] ?? .none
    }

    func sendConnectionRequest(to athlete: AthleteProfile, message: String) {
        connectionStatuses[athlete.id] = .pendingOutgoing
        let request = ConnectionRequest(
            id: UUID(),
            fromUserName: selectedRole == .scout ? MockData.scoutName : currentAthlete.fullName,
            toAthleteId: athlete.id,
            toAthleteName: athlete.fullName,
            message: message,
            status: .pendingOutgoing,
            createdAt: Date()
        )
        pendingRequests.insert(request, at: 0)
        showToast("Request sent to \(athlete.displayName)")
    }

    func acceptIncomingRequest(_ request: ConnectionRequest) {
        connectionStatuses[request.toAthleteId] = .connected
        if let index = pendingRequests.firstIndex(where: { $0.id == request.id }) {
            pendingRequests[index].status = .connected
        }
        showToast("Connected with \(request.fromUserName)")
    }

    func appendLocalReply(threadID: UUID, body: String) {
        guard let index = threads.firstIndex(where: { $0.id == threadID }) else { return }
        let name = selectedRole == .scout ? MockData.scoutName : currentAthlete.fullName
        let message = ChatMessage(
            id: UUID(),
            senderName: name,
            body: body,
            sentAt: Date(),
            isFromCurrentUser: true
        )
        threads[index].messages.append(message)
        threads[index].preview = body
        threads[index].updatedAt = Date()
        threads[index].unreadCount = 0
    }

    private func showToast(_ message: String) {
        toastMessage = message
        Task {
            try? await Task.sleep(nanoseconds: 2_000_000_000)
            if toastMessage == message {
                toastMessage = nil
            }
        }
    }
}
