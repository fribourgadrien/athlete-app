import SwiftUI

struct RolePickerView: View {
    @EnvironmentObject private var store: AppStore
    @State private var appeared = false

    var body: some View {
        ZStack {
            AppTheme.heroGradient
                .ignoresSafeArea()

            // Subtle pitch lines
            GeometryReader { geo in
                Path { path in
                    let midY = geo.size.height * 0.42
                    path.move(to: CGPoint(x: 0, y: midY))
                    path.addLine(to: CGPoint(x: geo.size.width, y: midY))
                    path.addEllipse(in: CGRect(
                        x: geo.size.width * 0.35,
                        y: midY - geo.size.width * 0.15,
                        width: geo.size.width * 0.3,
                        height: geo.size.width * 0.3
                    ))
                }
                .stroke(.white.opacity(0.08), lineWidth: 2)
            }
            .ignoresSafeArea()

            VStack(alignment: .leading, spacing: 0) {
                Spacer(minLength: 48)

                VStack(alignment: .leading, spacing: 12) {
                    Text("ATHLETE")
                        .font(.system(size: 13, weight: .bold, design: .rounded))
                        .tracking(4)
                        .foregroundStyle(AppTheme.amber)

                    Text("Your game.\nYour network.")
                        .font(.system(size: 40, weight: .bold, design: .rounded))
                        .foregroundStyle(.white)
                        .lineSpacing(2)

                    Text("A professional network for soccer athletes and the scouts who find them.")
                        .font(.system(size: 17, weight: .regular, design: .rounded))
                        .foregroundStyle(.white.opacity(0.78))
                        .padding(.top, 4)
                        .fixedSize(horizontal: false, vertical: true)
                }
                .padding(.horizontal, 28)
                .opacity(appeared ? 1 : 0)
                .offset(y: appeared ? 0 : 16)

                Spacer()

                VStack(spacing: 12) {
                    Text("Continue as")
                        .font(.subheadline.weight(.medium))
                        .foregroundStyle(.white.opacity(0.65))
                        .frame(maxWidth: .infinity, alignment: .leading)

                    ForEach(UserRole.allCases) { role in
                        Button {
                            store.completeOnboarding(role: role)
                        } label: {
                            HStack(spacing: 14) {
                                Image(systemName: role.systemImage)
                                    .font(.title2)
                                    .foregroundStyle(AppTheme.pitch)
                                    .frame(width: 44, height: 44)
                                    .background(AppTheme.mist)
                                    .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))

                                VStack(alignment: .leading, spacing: 3) {
                                    Text(role.title)
                                        .font(.headline)
                                        .foregroundStyle(AppTheme.charcoal)
                                    Text(role.subtitle)
                                        .font(.caption)
                                        .foregroundStyle(AppTheme.slate)
                                        .multilineTextAlignment(.leading)
                                }

                                Spacer(minLength: 8)

                                Image(systemName: "chevron.right")
                                    .font(.footnote.weight(.semibold))
                                    .foregroundStyle(AppTheme.slate)
                            }
                            .padding(14)
                            .background(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 36)
                .opacity(appeared ? 1 : 0)
                .offset(y: appeared ? 0 : 24)
            }
        }
        .onAppear {
            withAnimation(.easeOut(duration: 0.55)) {
                appeared = true
            }
        }
    }
}
