import SwiftUI

struct SettingsView: View {
    @EnvironmentObject private var store: AppStore

    var body: some View {
        List {
            Section {
                LabeledValue(label: "Role", value: store.selectedRole?.title ?? "—")
                LabeledValue(
                    label: "Account",
                    value: store.isScout ? store.scoutProfile.fullName : store.currentAthlete.fullName
                )
            } header: {
                sectionHeader("Account")
            }

            Section {
                NavigationLink {
                    NotificationsView()
                } label: {
                    Text("Notifications")
                        .font(AppFont.ui(15))
                        .foregroundStyle(AppTheme.ink)
                }
                NavigationLink {
                    ConnectionsView()
                } label: {
                    Text("Connections")
                        .font(AppFont.ui(15))
                        .foregroundStyle(AppTheme.ink)
                }
                NavigationLink {
                    ShortlistView()
                } label: {
                    Text(store.isScout ? "Shortlist" : "Saved athletes")
                        .font(AppFont.ui(15))
                        .foregroundStyle(AppTheme.ink)
                }
            } header: {
                sectionHeader("Network")
            }

            Section {
                Button {
                    store.resetOnboarding()
                } label: {
                    Text("Switch role")
                        .font(AppFont.ui(15, weight: .medium))
                        .foregroundStyle(AppTheme.cobalt)
                }
            } header: {
                sectionHeader("Session")
            }

            Section {
                Text("Mock data only · MVP shell")
                    .font(AppFont.ui(13))
                    .foregroundStyle(AppTheme.muted)
            } header: {
                sectionHeader("About")
            }
        }
        .listStyle(.insetGrouped)
        .scrollContentBackground(.hidden)
        .background(AppTheme.paper.ignoresSafeArea())
        .navigationTitle("Settings")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(AppTheme.paper, for: .navigationBar)
    }

    private func sectionHeader(_ title: String) -> some View {
        Text(title)
            .font(AppFont.ui(11, weight: .semibold))
            .tracking(1.0)
            .foregroundStyle(AppTheme.muted)
            .textCase(nil)
    }
}
