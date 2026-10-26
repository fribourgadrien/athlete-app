import SwiftUI

struct ProfileDetailView: View {
    @EnvironmentObject private var store: AppStore
    let athlete: AthleteProfile

    private var status: ConnectionStatus {
        store.status(for: athlete.id)
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 22) {
                hero
                stats
                about
                achievements
                connectCTA
            }
            .padding(20)
            .padding(.bottom, 24)
        }
        .background(AppTheme.backgroundGradient.ignoresSafeArea())
        .navigationTitle(athlete.displayName)
        .navigationBarTitleDisplayMode(.inline)
    }

    private var hero: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack(spacing: 16) {
                AvatarView(initials: athlete.initials, size: 68)
                VStack(alignment: .leading, spacing: 6) {
                    Text(athlete.fullName)
                        .font(.system(size: 24, weight: .bold, design: .rounded))
                        .foregroundStyle(AppTheme.charcoal)
                    Text("\(athlete.position.label) · \(athlete.nationality)")
                        .font(.subheadline)
                        .foregroundStyle(AppTheme.slate)
                    LevelBadge(level: athlete.level)
                }
            }

            Text(athlete.bio)
                .font(.body)
                .foregroundStyle(AppTheme.charcoal)

            Text("\(athlete.club) · \(athlete.location)")
                .font(.subheadline.weight(.medium))
                .foregroundStyle(AppTheme.pitch)
        }
    }

    private var stats: some View {
        HStack(spacing: 10) {
            StatTile(label: "Apps", value: "\(athlete.stats.appearances)")
            StatTile(label: "Goals", value: "\(athlete.stats.goals)")
            StatTile(label: "Assists", value: "\(athlete.stats.assists)")
            if let clean = athlete.stats.cleanSheets {
                StatTile(label: "CS", value: "\(clean)")
            }
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
                HStack(alignment: .top, spacing: 10) {
                    Image(systemName: "checkmark.seal.fill")
                        .foregroundStyle(AppTheme.turf)
                    Text(item)
                        .font(.subheadline)
                        .foregroundStyle(AppTheme.charcoal)
                }
            }
        }
    }

    @ViewBuilder
    private var connectCTA: some View {
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
                    .font(.headline)
                    .foregroundStyle(AppTheme.slate)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 14)
                    .background(AppTheme.mist)
                    .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))

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
                Label("Connected", systemImage: "person.2.fill")
                    .font(.headline)
                    .foregroundStyle(AppTheme.pitch)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 14)
                    .background(AppTheme.pitch.opacity(0.1))
                    .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
            }
        }
        .padding(.top, 8)
    }
}
