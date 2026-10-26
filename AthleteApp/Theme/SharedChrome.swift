import SwiftUI

/// Quiet monogram — square, flat, no gradient circle.
struct AvatarView: View {
    let initials: String
    var size: CGFloat = 44

    var body: some View {
        Text(initials)
            .font(AppFont.ui(size * 0.32, weight: .medium))
            .foregroundStyle(AppTheme.ink)
            .frame(width: size, height: size)
            .background(AppTheme.paper)
            .overlay(
                Rectangle()
                    .stroke(AppTheme.rule, lineWidth: 1)
            )
    }
}

struct LevelBadge: View {
    let level: CompetitiveLevel

    var body: some View {
        Text(level.rawValue.uppercased())
            .font(AppFont.ui(10, weight: .semibold))
            .tracking(0.8)
            .foregroundStyle(AppTheme.muted)
    }
}

struct MetaChip: View {
    let title: String
    let value: String

    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(title.uppercased())
                .font(AppFont.ui(10, weight: .medium))
                .tracking(0.6)
                .foregroundStyle(AppTheme.muted)
            Text(value)
                .font(AppFont.ui(14, weight: .medium))
                .foregroundStyle(AppTheme.ink)
        }
    }
}

/// Stats as typography — not mini-cards.
struct StatsLine: View {
    let stats: PlayerStats

    var body: some View {
        HStack(spacing: 0) {
            stat("\(stats.appearances)", "apps")
            separator
            stat("\(stats.goals)", "goals")
            separator
            stat("\(stats.assists)", "assists")
            if let clean = stats.cleanSheets {
                separator
                stat("\(clean)", "CS")
            }
        }
    }

    private var separator: some View {
        Text("  ·  ")
            .font(AppFont.ui(14))
            .foregroundStyle(AppTheme.rule)
    }

    private func stat(_ value: String, _ label: String) -> some View {
        HStack(alignment: .firstTextBaseline, spacing: 4) {
            Text(value)
                .font(AppFont.display(22, weight: .medium))
                .foregroundStyle(AppTheme.ink)
            Text(label)
                .font(AppFont.ui(12))
                .foregroundStyle(AppTheme.muted)
        }
    }
}

struct ProfileSection<Content: View>: View {
    let title: String
    @ViewBuilder var content: Content

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            Text(title.uppercased())
                .font(AppFont.ui(11, weight: .semibold))
                .tracking(1.2)
                .foregroundStyle(AppTheme.muted)
            VStack(alignment: .leading, spacing: 12) {
                content
            }
        }
    }
}

struct LabeledValue: View {
    let label: String
    let value: String

    var body: some View {
        HStack(alignment: .firstTextBaseline) {
            Text(label)
                .font(AppFont.ui(14))
                .foregroundStyle(AppTheme.muted)
            Spacer(minLength: 16)
            Text(value)
                .font(AppFont.ui(14, weight: .medium))
                .foregroundStyle(AppTheme.ink)
                .multilineTextAlignment(.trailing)
        }
    }
}

struct FlowTags: View {
    let tags: [String]

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            ForEach(tags, id: \.self) { tag in
                Text(tag)
                    .font(AppFont.ui(14))
                    .foregroundStyle(AppTheme.ink)
            }
        }
    }
}

struct Hairline: View {
    var body: some View {
        Rectangle()
            .fill(AppTheme.rule)
            .frame(height: 1)
    }
}
