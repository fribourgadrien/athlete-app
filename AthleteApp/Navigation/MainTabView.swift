import SwiftUI

struct MainTabView: View {
    @EnvironmentObject private var store: AppStore
    @State private var selectedTab = 0

    var body: some View {
        TabView(selection: $selectedTab) {
            NavigationStack {
                AthleteProfileView()
            }
            .tabItem {
                Label("Profile", systemImage: "person.crop.circle.fill")
            }
            .tag(0)

            DiscoveryFeedView()
                .tabItem {
                    Label("Discover", systemImage: "sportscourt.fill")
                }
                .tag(1)

            InboxView()
                .tabItem {
                    Label("Inbox", systemImage: "bubble.left.and.bubble.right.fill")
                }
                .badge(inboxBadge)
                .tag(2)
        }
        .tint(AppTheme.pitch)
        .overlay(alignment: .top) {
            if let toast = store.toastMessage {
                Text(toast)
                    .font(.subheadline.weight(.semibold))
                    .foregroundStyle(.white)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 10)
                    .background(AppTheme.pitchDeep.opacity(0.95))
                    .clipShape(Capsule())
                    .padding(.top, 8)
                    .transition(.move(edge: .top).combined(with: .opacity))
                    .animation(.spring(response: 0.35), value: store.toastMessage)
            }
        }
    }

    private var inboxBadge: Int {
        let unread = store.threads.reduce(0) { $0 + $1.unreadCount }
        let requests = store.pendingRequests.filter { $0.status == .pendingIncoming }.count
        return unread + requests
    }
}
