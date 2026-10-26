import SwiftUI

struct DiscoveryFeedView: View {
    @EnvironmentObject private var store: AppStore

    private let positionOptions: [SoccerPosition?] = [nil] + SoccerPosition.allCases.map { Optional($0) }
    private let levelOptions: [CompetitiveLevel?] = [nil] + CompetitiveLevel.allCases.map { Optional($0) }

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                searchField
                Hairline()
                filterRow
                Hairline()

                if store.filteredAthletes.isEmpty {
                    VStack(spacing: 8) {
                        Spacer()
                        Text("No matches")
                            .font(AppFont.display(22, weight: .medium))
                            .foregroundStyle(AppTheme.ink)
                        Text("Clear filters or refine your search.")
                            .font(AppFont.ui(14))
                            .foregroundStyle(AppTheme.muted)
                        Spacer()
                    }
                    .frame(maxWidth: .infinity)
                } else {
                    List(store.filteredAthletes) { athlete in
                        NavigationLink(value: athlete) {
                            AthleteRow(athlete: athlete)
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
            .navigationTitle("Discover")
            .navigationBarTitleDisplayMode(.large)
            .toolbarBackground(AppTheme.paper, for: .navigationBar)
            .navigationDestination(for: AthleteProfile.self) { athlete in
                ProfileDetailView(athlete: athlete)
            }
        }
    }

    private var searchField: some View {
        HStack(spacing: 10) {
            Text("Search")
                .font(AppFont.ui(13, weight: .medium))
                .foregroundStyle(AppTheme.muted)
            TextField("Name, club, city, position", text: $store.searchText)
                .font(AppFont.ui(15))
                .foregroundStyle(AppTheme.ink)
                .textInputAutocapitalization(.never)
                .disableAutocorrection(true)
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 14)
    }

    private var filterRow: some View {
        VStack(alignment: .leading, spacing: 10) {
            filterGroup(label: "Position") {
                ForEach(Array(positionOptions.enumerated()), id: \.offset) { _, option in
                    filterText(
                        title: option?.rawValue ?? "All",
                        selected: store.selectedPosition == option
                    ) {
                        store.selectedPosition = option
                    }
                }
            }
            filterGroup(label: "Level") {
                ForEach(Array(levelOptions.enumerated()), id: \.offset) { _, option in
                    filterText(
                        title: option?.rawValue ?? "All",
                        selected: store.selectedLevel == option
                    ) {
                        store.selectedLevel = option
                    }
                }
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 12)
    }

    private func filterGroup<Content: View>(label: String, @ViewBuilder content: () -> Content) -> some View {
        HStack(alignment: .firstTextBaseline, spacing: 12) {
            Text(label)
                .font(AppFont.ui(12, weight: .medium))
                .foregroundStyle(AppTheme.muted)
                .frame(width: 56, alignment: .leading)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 14) {
                    content()
                }
            }
        }
    }

    private func filterText(title: String, selected: Bool, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Text(title)
                .font(AppFont.ui(13, weight: selected ? .semibold : .regular))
                .foregroundStyle(selected ? AppTheme.ink : AppTheme.muted)
                .overlay(alignment: .bottom) {
                    if selected {
                        Rectangle()
                            .fill(AppTheme.ink)
                            .frame(height: 1)
                            .offset(y: 3)
                    }
                }
        }
        .buttonStyle(.plain)
    }
}

struct AthleteRow: View {
    let athlete: AthleteProfile

    var body: some View {
        HStack(alignment: .top, spacing: 14) {
            AvatarView(initials: athlete.initials, size: 40)

            VStack(alignment: .leading, spacing: 4) {
                HStack(alignment: .firstTextBaseline) {
                    Text(athlete.fullName)
                        .font(AppFont.ui(16, weight: .medium))
                        .foregroundStyle(AppTheme.ink)
                    Spacer(minLength: 8)
                    Text(athlete.position.rawValue)
                        .font(AppFont.ui(12, weight: .medium))
                        .foregroundStyle(AppTheme.muted)
                }

                Text("\(athlete.club)  ·  \(athlete.level.rawValue)")
                    .font(AppFont.ui(13))
                    .foregroundStyle(AppTheme.muted)
                    .lineLimit(1)

                Text("\(athlete.location)  ·  \(athlete.stats.goals)G \(athlete.stats.assists)A")
                    .font(AppFont.ui(12))
                    .foregroundStyle(AppTheme.muted)
            }
        }
    }
}
