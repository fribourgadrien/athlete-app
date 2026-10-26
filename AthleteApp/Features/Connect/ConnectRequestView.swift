import SwiftUI

struct ConnectRequestView: View {
    @EnvironmentObject private var store: AppStore
    @Environment(\.dismiss) private var dismiss

    let athlete: AthleteProfile
    @State private var message = ""
    @FocusState private var focused: Bool

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                VStack(alignment: .leading, spacing: 6) {
                    Text(athlete.fullName)
                        .font(AppFont.display(24, weight: .medium))
                        .foregroundStyle(AppTheme.ink)
                    Text("\(athlete.position.label)  ·  \(athlete.club)")
                        .font(AppFont.ui(14))
                        .foregroundStyle(AppTheme.muted)
                }

                Text("A short note introduces you. Both sides see it.")
                    .font(AppFont.ui(14))
                    .foregroundStyle(AppTheme.muted)

                VStack(alignment: .leading, spacing: 8) {
                    Text("MESSAGE")
                        .font(AppFont.ui(11, weight: .semibold))
                        .tracking(1.0)
                        .foregroundStyle(AppTheme.muted)

                    TextEditor(text: $message)
                        .focused($focused)
                        .font(AppFont.ui(15))
                        .frame(minHeight: 140)
                        .padding(12)
                        .scrollContentBackground(.hidden)
                        .background(AppTheme.surface)
                        .overlay(Rectangle().stroke(AppTheme.rule, lineWidth: 1))
                }

                Button("Send request") {
                    let body = message.trimmingCharacters(in: .whitespacesAndNewlines)
                    store.sendConnectionRequest(
                        to: athlete,
                        message: body.isEmpty
                            ? "I'd like to connect on Athlete."
                            : body
                    )
                    dismiss()
                }
                .buttonStyle(PrimaryButtonStyle())
                .disabled(store.status(for: athlete.id) != .none)

                Button("Cancel") { dismiss() }
                    .buttonStyle(SecondaryButtonStyle())
            }
            .padding(20)
        }
        .background(AppTheme.paper.ignoresSafeArea())
        .navigationTitle("Connect")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(AppTheme.paper, for: .navigationBar)
        .onAppear {
            if message.isEmpty {
                message = defaultMessage
            }
            focused = true
        }
    }

    private var defaultMessage: String {
        if store.selectedRole == .scout {
            return "Hi \(athlete.displayName) — I scout \(athlete.position.label.lowercased()) talent and would like to connect about opportunities."
        }
        return "Hi \(athlete.displayName) — impressed by your profile. Would love to connect and exchange notes."
    }
}
