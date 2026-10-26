import SwiftUI

struct ScoutProfileView: View {
    @EnvironmentObject private var store: AppStore

    private var scout: ScoutProfile { store.scoutProfile }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 28) {
                header
                Hairline()
                ProfileSection(title: "Focus") {
                    Text(scout.focus)
                        .font(AppFont.ui(15))
                        .foregroundStyle(AppTheme.ink)
                }
                ProfileSection(title: "Regions") {
                    ForEach(scout.regions, id: \.self) { region in
                        Text(region)
                            .font(AppFont.ui(14))
                            .foregroundStyle(AppTheme.ink)
                    }
                }
                ProfileSection(title: "Pipeline") {
                    NavigationLink {
                        ShortlistView()
                    } label: {
                        LabeledValue(label: "Shortlist", value: "\(store.shortlistedAthletes.count)")
                    }
                    .buttonStyle(.plain)
                    NavigationLink {
                        ConnectionsView()
                    } label: {
                        LabeledValue(label: "Connected", value: "\(store.connectedAthletes.count)")
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(.horizontal, 20)
            .padding(.top, 8)
            .padding(.bottom, 40)
        }
        .background(AppTheme.paper.ignoresSafeArea())
        .navigationTitle("Profile")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(AppTheme.paper, for: .navigationBar)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                NavigationLink {
                    SettingsView()
                } label: {
                    Image(systemName: "gearshape")
                        .font(AppFont.ui(15, weight: .medium))
                        .foregroundStyle(AppTheme.ink)
                }
            }
            ToolbarItem(placement: .topBarTrailing) {
                NavigationLink {
                    EditScoutProfileView(profile: scout)
                } label: {
                    Text("Edit")
                        .font(AppFont.ui(14, weight: .medium))
                        .foregroundStyle(AppTheme.cobalt)
                }
            }
        }
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack(alignment: .top, spacing: 16) {
                AvatarView(initials: scout.initials, size: 56)
                VStack(alignment: .leading, spacing: 6) {
                    Text(scout.fullName)
                        .font(AppFont.display(28, weight: .medium))
                        .foregroundStyle(AppTheme.ink)
                    Text("\(scout.title)  ·  \(scout.organization)")
                        .font(AppFont.ui(14))
                        .foregroundStyle(AppTheme.muted)
                    Text(scout.location)
                        .font(AppFont.ui(12))
                        .foregroundStyle(AppTheme.muted)
                }
            }

            Text(scout.bio)
                .font(AppFont.ui(15))
                .foregroundStyle(AppTheme.ink)
                .lineSpacing(3)
        }
    }
}

struct EditScoutProfileView: View {
    @EnvironmentObject private var store: AppStore
    @Environment(\.dismiss) private var dismiss
    @State private var draft: ScoutProfile

    init(profile: ScoutProfile) {
        _draft = State(initialValue: profile)
    }

    var body: some View {
        Form {
            Section {
                TextField("Full name", text: $draft.fullName)
                TextField("Title", text: $draft.title)
                TextField("Organization", text: $draft.organization)
                TextField("Location", text: $draft.location)
            } header: {
                Text("Identity")
                    .font(AppFont.ui(11, weight: .semibold))
                    .foregroundStyle(AppTheme.muted)
                    .textCase(nil)
            }

            Section {
                TextField("Focus", text: $draft.focus, axis: .vertical)
                    .lineLimit(2...4)
                TextField("Bio", text: $draft.bio, axis: .vertical)
                    .lineLimit(4...8)
            } header: {
                Text("About")
                    .font(AppFont.ui(11, weight: .semibold))
                    .foregroundStyle(AppTheme.muted)
                    .textCase(nil)
            }
        }
        .scrollContentBackground(.hidden)
        .background(AppTheme.paper.ignoresSafeArea())
        .navigationTitle("Edit profile")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Save") {
                    store.saveScoutProfile(draft)
                    dismiss()
                }
                .font(AppFont.ui(14, weight: .semibold))
                .foregroundStyle(AppTheme.cobalt)
            }
        }
    }
}
