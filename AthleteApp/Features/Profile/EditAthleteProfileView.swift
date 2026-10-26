import SwiftUI

struct EditAthleteProfileView: View {
    @EnvironmentObject private var store: AppStore
    @Environment(\.dismiss) private var dismiss

    @State private var draft: AthleteProfile

    init(profile: AthleteProfile) {
        _draft = State(initialValue: profile)
    }

    var body: some View {
        Form {
            Section {
                TextField("Full name", text: $draft.fullName)
                TextField("Club", text: $draft.club)
                TextField("Location", text: $draft.location)
                TextField("Nationality", text: $draft.nationality)
            } header: {
                sectionHeader("Identity")
            }

            Section {
                Picker("Position", selection: $draft.position) {
                    ForEach(SoccerPosition.allCases) { position in
                        Text(position.label).tag(position)
                    }
                }
                Picker("Level", selection: $draft.level) {
                    ForEach(CompetitiveLevel.allCases) { level in
                        Text(level.rawValue).tag(level)
                    }
                }
                Picker("Preferred foot", selection: $draft.preferredFoot) {
                    Text("Left").tag(PreferredFoot.left)
                    Text("Right").tag(PreferredFoot.right)
                    Text("Both").tag(PreferredFoot.both)
                }
                Stepper("Age: \(draft.age)", value: $draft.age, in: 14...45)
                Stepper("Height: \(draft.heightCm) cm", value: $draft.heightCm, in: 140...220)
            } header: {
                sectionHeader("Playing")
            }

            Section {
                TextField("Bio", text: $draft.bio, axis: .vertical)
                    .lineLimit(4...8)
            } header: {
                sectionHeader("About")
            }
        }
        .scrollContentBackground(.hidden)
        .background(AppTheme.paper.ignoresSafeArea())
        .navigationTitle("Edit profile")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(AppTheme.paper, for: .navigationBar)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Save") {
                    draft.displayName = shortened(draft.fullName)
                    store.saveAthleteProfile(draft)
                    dismiss()
                }
                .font(AppFont.ui(14, weight: .semibold))
                .foregroundStyle(AppTheme.cobalt)
            }
        }
    }

    private func sectionHeader(_ title: String) -> some View {
        Text(title)
            .font(AppFont.ui(11, weight: .semibold))
            .tracking(1.0)
            .foregroundStyle(AppTheme.muted)
            .textCase(nil)
    }

    private func shortened(_ name: String) -> String {
        let parts = name.split(separator: " ")
        guard let first = parts.first, let last = parts.last, parts.count > 1 else { return name }
        return "\(first.prefix(1)). \(last)"
    }
}
