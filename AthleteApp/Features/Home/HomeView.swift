import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var store: AppStore

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 28) {
                    if store.isScout {
                        scoutPipeline
                    } else {
                        athleteIntro
                    }
                    Hairline()
                    activitySection
                }
                .padding(.horizontal, 20)
                .padding(.top, 8)
                .padding(.bottom, 40)
            }
            .background(AppTheme.paper.ignoresSafeArea())
            .navigationTitle(store.isScout ? "Pipeline" : "Home")
            .toolbarBackground(AppTheme.paper, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink {
                        NotificationsView()
                    } label: {
                        ZStack(alignment: .topTrailing) {
                            Image(systemName: "bell")
                                .font(AppFont.ui(16, weight: .medium))
                                .foregroundStyle(AppTheme.ink)
                            if store.unreadNotificationCount > 0 {
                                Circle()
                                    .fill(AppTheme.cobalt)
                                    .frame(width: 7, height: 7)
                                    .offset(x: 3, y: -2)
                            }
                        }
                    }
                }
            }
            .navigationDestination(for: AthleteProfile.self) { athlete in
                ProfileDetailView(athlete: athlete)
            }
            .navigationDestination(for: HighlightClip.self) { clip in
                HighlightDetailView(clip: clip)
            }
        }
    }

    private var athleteIntro: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(store.currentAthlete.fullName)
                .font(AppFont.display(28, weight: .medium))
                .foregroundStyle(AppTheme.ink)
            Text("Your network activity across athletes and scouts.")
                .font(AppFont.ui(14))
                .foregroundStyle(AppTheme.muted)

            HStack(spacing: 20) {
                NavigationLink {
                    ConnectionsView()
                } label: {
                    metaStat("\(store.connectedAthletes.count)", "Connections")
                }
                .buttonStyle(.plain)

                NavigationLink {
                    ShortlistView()
                } label: {
                    metaStat("\(store.shortlistedAthletes.count)", "Saved")
                }
                .buttonStyle(.plain)
            }
            .padding(.top, 6)
        }
    }

    private var scoutPipeline: some View {
        VStack(alignment: .leading, spacing: 14) {
            Text(store.scoutProfile.fullName)
                .font(AppFont.display(28, weight: .medium))
                .foregroundStyle(AppTheme.ink)
            Text(store.scoutProfile.focus)
                .font(AppFont.ui(14))
                .foregroundStyle(AppTheme.muted)

            HStack(spacing: 20) {
                NavigationLink {
                    ShortlistView()
                } label: {
                    metaStat("\(store.shortlistedAthletes.count)", "Shortlist")
                }
                .buttonStyle(.plain)

                NavigationLink {
                    ConnectionsView()
                } label: {
                    metaStat("\(store.connectedAthletes.count)", "Connected")
                }
                .buttonStyle(.plain)
            }
            .padding(.top, 4)

            if !store.shortlistedAthletes.isEmpty {
                VStack(alignment: .leading, spacing: 0) {
                    Text("SHORTLIST")
                        .font(AppFont.ui(11, weight: .semibold))
                        .tracking(1.2)
                        .foregroundStyle(AppTheme.muted)
                        .padding(.bottom, 8)

                    ForEach(store.shortlistedAthletes.prefix(3)) { athlete in
                        NavigationLink(value: athlete) {
                            AthleteRow(athlete: athlete)
                                .padding(.vertical, 12)
                        }
                        .buttonStyle(.plain)
                        if athlete.id != store.shortlistedAthletes.prefix(3).last?.id {
                            Hairline()
                        }
                    }
                }
                .padding(.top, 8)
            }
        }
    }

    private var activitySection: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("ACTIVITY")
                .font(AppFont.ui(11, weight: .semibold))
                .tracking(1.2)
                .foregroundStyle(AppTheme.muted)
                .padding(.bottom, 8)

            ForEach(store.activity) { item in
                activityRow(item)
                if item.id != store.activity.last?.id {
                    Hairline()
                }
            }
        }
    }

    @ViewBuilder
    private func activityRow(_ item: ActivityItem) -> some View {
        let row = HStack(alignment: .top, spacing: 12) {
            Text(kindGlyph(item.kind))
                .font(AppFont.ui(12, weight: .semibold))
                .foregroundStyle(AppTheme.cobalt)
                .frame(width: 28, alignment: .leading)

            VStack(alignment: .leading, spacing: 4) {
                Text(item.title)
                    .font(AppFont.ui(15, weight: .medium))
                    .foregroundStyle(AppTheme.ink)
                Text(item.subtitle)
                    .font(AppFont.ui(13))
                    .foregroundStyle(AppTheme.muted)
                Text(item.timestamp, style: .relative)
                    .font(AppFont.ui(11))
                    .foregroundStyle(AppTheme.muted)
            }
            Spacer(minLength: 0)
        }
        .padding(.vertical, 14)
        .contentShape(Rectangle())

        if let athleteID = item.relatedAthleteId, let athlete = store.athlete(id: athleteID) {
            NavigationLink(value: athlete) { row }
                .buttonStyle(.plain)
        } else {
            row
        }
    }

    private func metaStat(_ value: String, _ label: String) -> some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(value)
                .font(AppFont.display(22, weight: .medium))
                .foregroundStyle(AppTheme.ink)
            Text(label)
                .font(AppFont.ui(12))
                .foregroundStyle(AppTheme.muted)
        }
    }

    private func kindGlyph(_ kind: ActivityKind) -> String {
        switch kind {
        case .connection: return "·"
        case .highlight: return "▷"
        case .shortlist: return "◆"
        case .request: return "→"
        }
    }
}
