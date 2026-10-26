import SwiftUI

struct DiscoveryFeedView: View {
    @EnvironmentObject private var store: AppStore

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                searchBar
                filterBar

                if store.filteredAthletes.isEmpty {
                    ContentUnavailableView(
                        "No athletes match",
                        systemImage: "sportscourt",
                        description: Text("Try clearing filters or refining your search.")
                    )
                    .frame(maxHeight: .infinity)
                } else {
                    List(store.filteredAthletes) { athlete in
                        NavigationLink(value: athlete) {
                            AthleteRow(athlete: athlete)
                        }
                        .listRowBackground(Color.white.opacity(0.55))
                        .listRowSeparatorTint(AppTheme.mist)
                    }
                    .listStyle(.plain)
                    .scrollContentBackground(.hidden)
                }
            }
            .background(AppTheme.backgroundGradient.ignoresSafeArea())
            .navigationTitle("Discover")
            .navigationDestination(for: AthleteProfile.self) { athlete in
                ProfileDetailView(athlete: athlete)
            }
        }
    }

    private var searchBar: some View {
        HStack(spacing: 10) {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(AppTheme.slate)
            TextField("Search name, club, city, position", text: $store.searchText)
                .textInputAutocapitalization(.never)
                .disableAutocorrection(true)
        }
        .padding(12)
        .background(.white.opacity(0.8))
        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
        .padding(.horizontal, 16)
        .padding(.top, 8)
        .padding(.bottom, 10)
    }

    private var filterBar: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                FilterChip(
                    title: "All positions",
                    isSelected: store.selectedPosition == nil
                ) {
                    store.selectedPosition = nil
                }

                ForEach(SoccerPosition.allCases) { position in
                    FilterChip(
                        title: position.rawValue,
                        isSelected: store.selectedPosition == position
                    ) {
                        store.selectedPosition = store.selectedPosition == position ? nil : position
                    }
                }

                Divider().frame(height: 20)

                FilterChip(
                    title: "All levels",
                    isSelected: store.selectedLevel == nil
                ) {
                    store.selectedLevel = nil
                }

                ForEach(CompetitiveLevel.allCases) { level in
                    FilterChip(
                        title: level.rawValue,
                        isSelected: store.selectedLevel == level
                    ) {
                        store.selectedLevel = store.selectedLevel == level ? nil : level
                    }
                }
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 12)
        }
    }
}

struct AthleteRow: View {
    let athlete: AthleteProfile

    var body: some View {
        HStack(spacing: 14) {
            AvatarView(initials: athlete.initials, size: 48)

            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text(athlete.fullName)
                        .font(.headline)
                        .foregroundStyle(AppTheme.charcoal)
                    Spacer()
                    Text(athlete.position.rawValue)
                        .font(.caption.weight(.bold))
                        .foregroundStyle(AppTheme.pitch)
                }

                Text("\(athlete.club) · \(athlete.level.rawValue)")
                    .font(.subheadline)
                    .foregroundStyle(AppTheme.slate)
                    .lineLimit(1)

                Text("\(athlete.location) · \(athlete.stats.goals)G \(athlete.stats.assists)A")
                    .font(.caption)
                    .foregroundStyle(AppTheme.slate)
            }
        }
        .padding(.vertical, 6)
    }
}

struct FilterChip: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.caption.weight(.semibold))
                .foregroundStyle(isSelected ? .white : AppTheme.pitch)
                .padding(.horizontal, 12)
                .padding(.vertical, 7)
                .background(isSelected ? AppTheme.pitch : Color.white.opacity(0.85))
                .clipShape(Capsule())
        }
        .buttonStyle(.plain)
    }
}
