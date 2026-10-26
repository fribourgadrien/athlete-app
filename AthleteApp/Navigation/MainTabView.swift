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
                Label("Profile", systemImage: "person")
            }
            .tag(0)

            DiscoveryFeedView()
                .tabItem {
                    Label("Discover", systemImage: "magnifyingglass")
                }
                .tag(1)

            InboxView()
                .tabItem {
                    Label("Inbox", systemImage: "envelope")
                }
                .badge(inboxBadge)
                .tag(2)
        }
        .tint(AppTheme.ink)
        .overlay(alignment: .top) {
            if let toast = store.toastMessage {
                Text(toast)
                    .font(AppFont.ui(13, weight: .medium))
                    .foregroundStyle(AppTheme.paper)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 10)
                    .background(AppTheme.ink)
                    .padding(.top, 8)
                    .transition(.opacity)
            }
        }
        .animation(.easeOut(duration: 0.25), value: store.toastMessage)
    }

    private var inboxBadge: Int {
        let unread = store.threads.reduce(0) { $0 + $1.unreadCount }
        let requests = store.pendingRequests.filter { $0.status == .pendingIncoming }.count
        return unread + requests
    }
}
