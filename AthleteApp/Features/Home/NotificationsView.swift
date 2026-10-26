import SwiftUI

struct NotificationsView: View {
    @EnvironmentObject private var store: AppStore

    var body: some View {
        List {
            ForEach(store.notifications) { note in
                VStack(alignment: .leading, spacing: 6) {
                    HStack(alignment: .firstTextBaseline) {
                        Text(note.title)
                            .font(AppFont.ui(15, weight: note.isRead ? .medium : .semibold))
                            .foregroundStyle(AppTheme.ink)
                        Spacer()
                        if !note.isRead {
                            Circle()
                                .fill(AppTheme.cobalt)
                                .frame(width: 6, height: 6)
                        }
                    }
                    Text(note.body)
                        .font(AppFont.ui(14))
                        .foregroundStyle(AppTheme.muted)
                    Text(note.timestamp, style: .relative)
                        .font(AppFont.ui(11))
                        .foregroundStyle(AppTheme.muted)
                }
                .padding(.vertical, 8)
                .listRowBackground(AppTheme.paper)
                .listRowSeparatorTint(AppTheme.rule)
            }
        }
        .listStyle(.plain)
        .scrollContentBackground(.hidden)
        .background(AppTheme.paper.ignoresSafeArea())
        .navigationTitle("Notifications")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(AppTheme.paper, for: .navigationBar)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Mark read") {
                    store.markNotificationsRead()
                }
                .font(AppFont.ui(14, weight: .medium))
                .foregroundStyle(AppTheme.cobalt)
            }
        }
    }
}
