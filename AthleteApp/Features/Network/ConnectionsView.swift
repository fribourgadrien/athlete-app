import SwiftUI

struct ConnectionsView: View {
    @EnvironmentObject private var store: AppStore

    var body: some View {
        Group {
            if store.connectedAthletes.isEmpty {
                VStack(spacing: 8) {
                    Spacer()
                    Text("No connections yet")
                        .font(AppFont.display(22, weight: .medium))
                        .foregroundStyle(AppTheme.ink)
                    Text("Discover athletes and send a request.")
                        .font(AppFont.ui(14))
                        .foregroundStyle(AppTheme.muted)
                    Spacer()
                }
                .frame(maxWidth: .infinity)
            } else {
                List(store.connectedAthletes) { athlete in
                    NavigationLink {
                        ProfileDetailView(athlete: athlete)
                    } label: {
                        AthleteRow(athlete: athlete)
                    }
                    .listRowInsets(EdgeInsets(top: 14, leading: 20, bottom: 14, trailing: 20))
                    .listRowBackground(AppTheme.paper)
                    .listRowSeparatorTint(AppTheme.rule)
                }
                .listStyle(.plain)
                .scrollContentBackground(.hidden)
            }
        }
        .background(AppTheme.paper.ignoresSafeArea())
        .navigationTitle("Connections")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(AppTheme.paper, for: .navigationBar)
    }
}
