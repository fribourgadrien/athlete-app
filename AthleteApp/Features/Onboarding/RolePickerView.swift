import SwiftUI

struct RolePickerView: View {
    @EnvironmentObject private var store: AppStore
    @State private var appeared = false

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Spacer(minLength: 56)

            VStack(alignment: .leading, spacing: 18) {
                Text("Athlete")
                    .font(AppFont.display(48, weight: .bold))
                    .foregroundStyle(.white)

                Text("Professional networking for soccer.")
                    .font(AppFont.displayItalic(18))
                    .foregroundStyle(.white.opacity(0.85))
                    .fixedSize(horizontal: false, vertical: true)
            }
            .padding(.horizontal, 28)
            .opacity(appeared ? 1 : 0)
            .offset(y: appeared ? 0 : 12)

            Spacer()

            VStack(spacing: 0) {
                Rectangle()
                    .fill(.white.opacity(0.22))
                    .frame(height: 1)

                ForEach(UserRole.allCases) { role in
                    Button {
                        store.completeOnboarding(role: role)
                    } label: {
                        HStack(alignment: .firstTextBaseline) {
                            VStack(alignment: .leading, spacing: 4) {
                                Text(role.title)
                                    .font(AppFont.ui(17, weight: .semibold))
                                    .foregroundStyle(.white)
                                Text(role.shortSubtitle)
                                    .font(AppFont.ui(14))
                                    .foregroundStyle(.white.opacity(0.72))
                            }
                            Spacer()
                            Text("→")
                                .font(AppFont.ui(17, weight: .medium))
                                .foregroundStyle(.white.opacity(0.7))
                        }
                        .padding(.horizontal, 28)
                        .padding(.vertical, 20)
                        .contentShape(Rectangle())
                    }
                    .buttonStyle(.plain)

                    Rectangle()
                        .fill(.white.opacity(0.22))
                        .frame(height: 1)
                }
            }
            .opacity(appeared ? 1 : 0)
            .padding(.bottom, 28)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(AppTheme.cobalt.ignoresSafeArea())
        .onAppear {
            withAnimation(.easeOut(duration: 0.4)) {
                appeared = true
            }
        }
    }
}

private extension UserRole {
    var shortSubtitle: String {
        switch self {
        case .athlete: return "Build your sporting profile"
        case .scout: return "Find and evaluate talent"
        }
    }
}
