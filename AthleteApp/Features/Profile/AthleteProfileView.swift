import SwiftUI

struct AthleteProfileView: View {
    @EnvironmentObject private var store: AppStore

    private var athlete: AthleteProfile { store.currentAthlete }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                header
                statsRow
                aboutSection
                achievementsSection
                highlightsSection
                lookingForSection
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 32)
        }
        .background(AppTheme.backgroundGradient.ignoresSafeArea())
        .navigationTitle("My Profile")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Switch role") {
                    store.resetOnboarding()
                }
                .font(.subheadline.weight(.medium))
                .foregroundStyle(AppTheme.pitch)
            }
        }
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack(alignment: .center, spacing: 16) {
                AvatarView(initials: athlete.initials, size: 72)

                VStack(alignment: .leading, spacing: 6) {
                    Text(athlete.fullName)
                        .font(.system(size: 26, weight: .bold, design: .rounded))
                        .foregroundStyle(AppTheme.charcoal)

                    Text("\(athlete.position.label) · \(athlete.club)")
                        .font(.subheadline)
                        .foregroundStyle(AppTheme.slate)

                    HStack(spacing: 8) {
                        LevelBadge(level: athlete.level)
                        Text(athlete.location)
                            .font(.caption)
                            .foregroundStyle(AppTheme.slate)
                    }
                }
            }

            Text(athlete.bio)
                .font(.body)
                .foregroundStyle(AppTheme.charcoal)
                .fixedSize(horizontal: false, vertical: true)

            HStack(spacing: 20) {
                MetaChip(title: "Age", value: "\(athlete.age)")
                MetaChip(title: "Height", value: "\(athlete.heightCm) cm")
                MetaChip(title: "Foot", value: athlete.preferredFoot.rawValue)
                MetaChip(title: "Network", value: "\(athlete.connectionCount)")
            }
        }
        .padding(.top, 8)
    }

    private var statsRow: some View {
        HStack(spacing: 10) {
            StatTile(label: "Apps", value: "\(athlete.stats.appearances)")
            StatTile(label: "Goals", value: "\(athlete.stats.goals)")
            StatTile(label: "Assists", value: "\(athlete.stats.assists)")
            if let clean = athlete.stats.cleanSheets {
                StatTile(label: "CS", value: "\(clean)")
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
                HStack(alignment: .top, spacing: 10) {
                    Image(systemName: "rosette")
                        .foregroundStyle(AppTheme.amber)
                    Text(item)
                        .font(.subheadline)
                        .foregroundStyle(AppTheme.charcoal)
                }
            }
        }
    }

    private var highlightsSection: some View {
        ProfileSection(title: "Highlights") {
            ForEach(athlete.highlightTitles, id: \.self) { title in
                HStack(spacing: 12) {
                    RoundedRectangle(cornerRadius: 8, style: .continuous)
                        .fill(AppTheme.pitch.opacity(0.12))
                        .frame(width: 52, height: 36)
                        .overlay {
                            Image(systemName: "play.fill")
                                .font(.caption)
                                .foregroundStyle(AppTheme.pitch)
                        }
                    Text(title)
                        .font(.subheadline.weight(.medium))
                        .foregroundStyle(AppTheme.charcoal)
                    Spacer()
                }
            }
        }
    }

    private var lookingForSection: some View {
        ProfileSection(title: "Looking for") {
            FlowTags(tags: athlete.lookingFor)
        }
    }
}

// MARK: - Shared profile chrome

struct AvatarView: View {
    let initials: String
    var size: CGFloat = 56

    var body: some View {
        Text(initials)
            .font(.system(size: size * 0.34, weight: .bold, design: .rounded))
            .foregroundStyle(.white)
            .frame(width: size, height: size)
            .background(AppTheme.heroGradient)
            .clipShape(Circle())
    }
}

struct LevelBadge: View {
    let level: CompetitiveLevel

    var body: some View {
        Text(level.rawValue)
            .font(.caption2.weight(.bold))
            .tracking(0.4)
            .foregroundStyle(AppTheme.pitch)
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(AppTheme.pitch.opacity(0.12))
            .clipShape(Capsule())
    }
}

struct MetaChip: View {
    let title: String
    let value: String

    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(title.uppercased())
                .font(.system(size: 10, weight: .semibold, design: .rounded))
                .foregroundStyle(AppTheme.slate)
            Text(value)
                .font(.subheadline.weight(.semibold))
                .foregroundStyle(AppTheme.charcoal)
        }
    }
}

struct StatTile: View {
    let label: String
    let value: String

    var body: some View {
        VStack(spacing: 4) {
            Text(value)
                .font(.system(size: 22, weight: .bold, design: .rounded))
                .foregroundStyle(AppTheme.pitch)
            Text(label)
                .font(.caption2.weight(.medium))
                .foregroundStyle(AppTheme.slate)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 14)
        .background(.white.opacity(0.7))
        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
    }
}

struct ProfileSection<Content: View>: View {
    let title: String
    @ViewBuilder var content: Content

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .font(.system(size: 15, weight: .bold, design: .rounded))
                .foregroundStyle(AppTheme.charcoal)
            VStack(alignment: .leading, spacing: 10) {
                content
            }
        }
    }
}

struct LabeledValue: View {
    let label: String
    let value: String

    var body: some View {
        HStack {
            Text(label)
                .font(.subheadline)
                .foregroundStyle(AppTheme.slate)
            Spacer()
            Text(value)
                .font(.subheadline.weight(.medium))
                .foregroundStyle(AppTheme.charcoal)
                .multilineTextAlignment(.trailing)
        }
    }
}

struct FlowTags: View {
    let tags: [String]

    var body: some View {
        FlexibleTagLayout(spacing: 8) {
            ForEach(tags, id: \.self) { tag in
                Text(tag)
                    .font(.caption.weight(.semibold))
                    .foregroundStyle(AppTheme.pitch)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 6)
                    .background(AppTheme.mist)
                    .clipShape(Capsule())
            }
        }
    }
}

/// Simple wrapping layout for tags without external dependencies.
struct FlexibleTagLayout: Layout {
    var spacing: CGFloat = 8

    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let result = arrange(proposal: proposal, subviews: subviews)
        return result.size
    }

    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        let result = arrange(proposal: proposal, subviews: subviews)
        for (index, position) in result.positions.enumerated() {
            subviews[index].place(
                at: CGPoint(x: bounds.minX + position.x, y: bounds.minY + position.y),
                proposal: .unspecified
            )
        }
    }

    private func arrange(proposal: ProposedViewSize, subviews: Subviews) -> (size: CGSize, positions: [CGPoint]) {
        let maxWidth = proposal.width ?? .infinity
        var positions: [CGPoint] = []
        var x: CGFloat = 0
        var y: CGFloat = 0
        var rowHeight: CGFloat = 0
        var width: CGFloat = 0

        for subview in subviews {
            let size = subview.sizeThatFits(.unspecified)
            if x + size.width > maxWidth, x > 0 {
                x = 0
                y += rowHeight + spacing
                rowHeight = 0
            }
            positions.append(CGPoint(x: x, y: y))
            rowHeight = max(rowHeight, size.height)
            x += size.width + spacing
            width = max(width, x - spacing)
        }

        return (CGSize(width: width, height: y + rowHeight), positions)
    }
}
