import SwiftUI

struct ShortlistView: View {
    @EnvironmentObject private var store: AppStore

    var body: some View {
        Group {
            if store.shortlistedAthletes.isEmpty {
                VStack(spacing: 8) {
                    Spacer()
                    Text("Shortlist empty")
                        .font(AppFont.display(22, weight: .medium))
                        .foregroundStyle(AppTheme.ink)
                    Text(store.isScout
                          ? "Save athletes from Discover while you evaluate."
                          : "Save profiles to revisit later.")
                        .font(AppFont.ui(14))
                        .foregroundStyle(AppTheme.muted)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 32)
                    Spacer()
                }
                .frame(maxWidth: .infinity)
            } else {
                List(store.shortlistedAthletes) { athlete in
                    NavigationLink {
                        ProfileDetailView(athlete: athlete)
                    } label: {
                        AthleteRow(athlete: athlete)
                    }
                    .swipeActions(edge: .trailing) {
                        Button("Remove") {
                            store.toggleShortlist(athlete)
                        }
                        .tint(AppTheme.ink)
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
        .navigationTitle(store.isScout ? "Shortlist" : "Saved")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(AppTheme.paper, for: .navigationBar)
    }
}
