import SwiftUI

struct ConnectRequestView: View {
    @EnvironmentObject private var store: AppStore
    @Environment(\.dismiss) private var dismiss

    let athlete: AthleteProfile
    @State private var message = ""
    @FocusState private var focused: Bool

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                HStack(spacing: 14) {
                    AvatarView(initials: athlete.initials, size: 56)
                    VStack(alignment: .leading, spacing: 4) {
                        Text(athlete.fullName)
                            .font(.title3.weight(.bold))
                            .foregroundStyle(AppTheme.charcoal)
                        Text("\(athlete.position.label) · \(athlete.club)")
                            .font(.subheadline)
                            .foregroundStyle(AppTheme.slate)
                    }
                }

                Text("Introduce yourself and why you’d like to connect. Keep it professional — scouts and athletes both see this note.")
                    .font(.subheadline)
                    .foregroundStyle(AppTheme.slate)

                VStack(alignment: .leading, spacing: 8) {
                    Text("Message")
                        .font(.caption.weight(.semibold))
                        .foregroundStyle(AppTheme.slate)

                    TextEditor(text: $message)
                        .focused($focused)
                        .frame(minHeight: 140)
                        .padding(10)
                        .scrollContentBackground(.hidden)
                        .background(Color.white.opacity(0.85))
                        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                        .overlay(
                            RoundedRectangle(cornerRadius: 12, style: .continuous)
                                .stroke(AppTheme.mist, lineWidth: 1)
                        )
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
        .background(AppTheme.backgroundGradient.ignoresSafeArea())
        .navigationTitle("Connect")
        .navigationBarTitleDisplayMode(.inline)
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
