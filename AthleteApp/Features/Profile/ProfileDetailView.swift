import SwiftUI

struct ProfileDetailView: View {
    @EnvironmentObject private var store: AppStore
    let athlete: AthleteProfile

    private var status: ConnectionStatus {
        store.status(for: athlete.id)
    }

    private var clips: [HighlightClip] {
        store.highlights(for: athlete.id)
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 28) {
                hero
                Hairline()
                StatsLine(stats: athlete.stats)
                Hairline()
                about
                achievements
                if !clips.isEmpty {
                    highlights
                }
                actions
            }
            .padding(.horizontal, 20)
            .padding(.top, 12)
            .padding(.bottom, 40)
        }
        .background(AppTheme.paper.ignoresSafeArea())
        .navigationTitle(athlete.displayName)
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(AppTheme.paper, for: .navigationBar)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(store.isShortlisted(athlete.id) ? "Saved" : "Save") {
                    store.toggleShortlist(athlete)
                }
                .font(AppFont.ui(14, weight: .medium))
                .foregroundStyle(AppTheme.cobalt)
            }
        }
    }

    private var hero: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack(alignment: .top, spacing: 16) {
                AvatarView(initials: athlete.initials, size: 56)
                VStack(alignment: .leading, spacing: 6) {
                    Text(athlete.fullName)
                        .font(AppFont.display(26, weight: .medium))
                        .foregroundStyle(AppTheme.ink)
                    Text("\(athlete.position.label)  ·  \(athlete.nationality)")
                        .font(AppFont.ui(14))
                        .foregroundStyle(AppTheme.muted)
                    LevelBadge(level: athlete.level)
                }
            }

            Text(athlete.bio)
                .font(AppFont.ui(15))
                .foregroundStyle(AppTheme.ink)
                .lineSpacing(3)

            Text("\(athlete.club)  ·  \(athlete.location)")
                .font(AppFont.ui(13, weight: .medium))
                .foregroundStyle(AppTheme.cobalt)
        }
    }

    private var about: some View {
        ProfileSection(title: "Profile") {
            LabeledValue(label: "Age", value: "\(athlete.age)")
            LabeledValue(label: "Height", value: "\(athlete.heightCm) cm")
            LabeledValue(label: "Preferred foot", value: athlete.preferredFoot.rawValue)
            LabeledValue(label: "Connections", value: "\(athlete.connectionCount)")
        }
    }

    private var achievements: some View {
        ProfileSection(title: "Achievements") {
            ForEach(athlete.achievements, id: \.self) { item in
                Text(item)
                    .font(AppFont.ui(14))
                    .foregroundStyle(AppTheme.ink)
            }
        }
    }

    private var highlights: some View {
        ProfileSection(title: "Highlights") {
            ForEach(clips) { clip in
                NavigationLink {
                    HighlightDetailView(clip: clip)
                } label: {
                    HStack {
                        Text(clip.title)
                            .font(AppFont.ui(14))
                            .foregroundStyle(AppTheme.ink)
                        Spacer()
                        Text(clip.durationLabel)
                            .font(AppFont.ui(12))
                            .foregroundStyle(AppTheme.muted)
                    }
                }
                .buttonStyle(.plain)
            }
        }
    }

    @ViewBuilder
    private var actions: some View {
        VStack(spacing: 10) {
            switch status {
            case .none:
                NavigationLink {
                    ConnectRequestView(athlete: athlete)
                } label: {
                    Text("Connect")
                }
                .buttonStyle(PrimaryButtonStyle())

            case .pendingOutgoing:
                Text("Request pending")
                    .font(AppFont.ui(14, weight: .medium))
                    .foregroundStyle(AppTheme.muted)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 14)
                    .overlay(Rectangle().stroke(AppTheme.rule, lineWidth: 1))

            case .pendingIncoming:
                Button("Accept connection") {
                    if let request = store.pendingRequests.first(where: {
                        $0.toAthleteId == athlete.id || $0.fromUserName == athlete.fullName
                    }) {
                        store.acceptIncomingRequest(request)
                    }
                }
                .buttonStyle(PrimaryButtonStyle())

            case .connected:
                Text("Connected")
                    .font(AppFont.ui(14, weight: .medium))
                    .foregroundStyle(AppTheme.muted)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 14)
                    .overlay(Rectangle().stroke(AppTheme.rule, lineWidth: 1))
            }
        }
        .padding(.top, 8)
    }
}
