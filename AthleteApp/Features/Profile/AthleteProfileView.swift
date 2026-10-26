import SwiftUI

struct AthleteProfileView: View {
    @EnvironmentObject private var store: AppStore

    private var athlete: AthleteProfile { store.currentAthlete }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 28) {
                header
                Hairline()
                StatsLine(stats: athlete.stats)
                Hairline()
                aboutSection
                achievementsSection
                highlightsSection
                lookingForSection
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
            ToolbarItem(placement: .topBarTrailing) {
                Button("Switch role") {
                    store.resetOnboarding()
                }
                .font(AppFont.ui(14, weight: .medium))
                .foregroundStyle(AppTheme.cobalt)
            }
        }
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack(alignment: .top, spacing: 16) {
                AvatarView(initials: athlete.initials, size: 56)

                VStack(alignment: .leading, spacing: 6) {
                    Text(athlete.fullName)
                        .font(AppFont.display(28, weight: .medium))
                        .foregroundStyle(AppTheme.ink)

                    Text("\(athlete.position.label)  ·  \(athlete.club)")
                        .font(AppFont.ui(14))
                        .foregroundStyle(AppTheme.muted)

                    HStack(spacing: 10) {
                        LevelBadge(level: athlete.level)
                        Text(athlete.location)
                            .font(AppFont.ui(12))
                            .foregroundStyle(AppTheme.muted)
                    }
                }
            }

            Text(athlete.bio)
                .font(AppFont.ui(15))
                .foregroundStyle(AppTheme.ink)
                .lineSpacing(3)
                .fixedSize(horizontal: false, vertical: true)

            HStack(spacing: 24) {
                MetaChip(title: "Age", value: "\(athlete.age)")
                MetaChip(title: "Height", value: "\(athlete.heightCm) cm")
                MetaChip(title: "Foot", value: athlete.preferredFoot.rawValue)
                MetaChip(title: "Network", value: "\(athlete.connectionCount)")
            }
        }
    }

    private var aboutSection: some View {
        ProfileSection(title: "Identity") {
            LabeledValue(label: "Nationality", value: athlete.nationality)
            LabeledValue(label: "Position", value: "\(athlete.position.rawValue) — \(athlete.position.label)")
            LabeledValue(label: "Club", value: athlete.club)
        }
    }

    private var achievementsSection: some View {
        ProfileSection(title: "Achievements") {
            ForEach(athlete.achievements, id: \.self) { item in
                Text(item)
                    .font(AppFont.ui(14))
                    .foregroundStyle(AppTheme.ink)
            }
        }
    }

    private var highlightsSection: some View {
        ProfileSection(title: "Highlights") {
            ForEach(athlete.highlightTitles, id: \.self) { title in
                Text(title)
                    .font(AppFont.ui(14))
                    .foregroundStyle(AppTheme.ink)
            }
        }
    }

    private var lookingForSection: some View {
        ProfileSection(title: "Looking for") {
            FlowTags(tags: athlete.lookingFor)
        }
    }
}
