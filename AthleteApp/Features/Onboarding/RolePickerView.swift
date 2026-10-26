import SwiftUI

struct RolePickerView: View {
    @EnvironmentObject private var store: AppStore
    @State private var appeared = false

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Spacer(minLength: 64)

            VStack(alignment: .leading, spacing: 16) {
                Text("Athlete")
                    .font(AppFont.display(44, weight: .medium))
                    .foregroundStyle(AppTheme.ink)

                Text("Professional networking for soccer.")
                    .font(AppFont.ui(17))
                    .foregroundStyle(AppTheme.muted)
                    .fixedSize(horizontal: false, vertical: true)
            }
            .padding(.horizontal, 28)
            .opacity(appeared ? 1 : 0)
            .offset(y: appeared ? 0 : 10)

            Spacer()

            VStack(spacing: 0) {
                Hairline()
                ForEach(UserRole.allCases) { role in
                    Button {
                        store.completeOnboarding(role: role)
                    } label: {
                        HStack(alignment: .firstTextBaseline) {
                            VStack(alignment: .leading, spacing: 4) {
                                Text(role.title)
                                    .font(AppFont.ui(17, weight: .medium))
                                    .foregroundStyle(AppTheme.ink)
                                Text(role.shortSubtitle)
                                    .font(AppFont.ui(14))
                                    .foregroundStyle(AppTheme.muted)
                            }
                            Spacer()
                            Text("→")
                                .font(AppFont.ui(17))
                                .foregroundStyle(AppTheme.muted)
                        }
                        .padding(.horizontal, 28)
                        .padding(.vertical, 20)
                        .contentShape(Rectangle())
                    }
                    .buttonStyle(.plain)
                    Hairline()
                }
            }
            .opacity(appeared ? 1 : 0)
            .padding(.bottom, 24)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(AppTheme.paper.ignoresSafeArea())
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
