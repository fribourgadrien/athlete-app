import SwiftUI

enum AppTheme {
    static let pitch = Color(red: 0.07, green: 0.28, blue: 0.20)
    static let pitchDeep = Color(red: 0.04, green: 0.16, blue: 0.12)
    static let turf = Color(red: 0.18, green: 0.52, blue: 0.36)
    static let chalk = Color(red: 0.96, green: 0.97, blue: 0.95)
    static let mist = Color(red: 0.90, green: 0.93, blue: 0.91)
    static let charcoal = Color(red: 0.12, green: 0.14, blue: 0.13)
    static let slate = Color(red: 0.35, green: 0.40, blue: 0.38)
    static let amber = Color(red: 0.78, green: 0.55, blue: 0.18)
    static let danger = Color(red: 0.72, green: 0.22, blue: 0.18)

    static var backgroundGradient: LinearGradient {
        LinearGradient(
            colors: [
                chalk,
                mist,
                Color(red: 0.86, green: 0.91, blue: 0.88)
            ],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }

    static var heroGradient: LinearGradient {
        LinearGradient(
            colors: [pitchDeep, pitch, turf.opacity(0.85)],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
}

struct PrimaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.headline.weight(.semibold))
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 14)
            .background(AppTheme.pitch)
            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
            .opacity(configuration.isPressed ? 0.88 : 1)
            .scaleEffect(configuration.isPressed ? 0.98 : 1)
            .animation(.easeOut(duration: 0.15), value: configuration.isPressed)
    }
}

struct SecondaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.headline.weight(.semibold))
            .foregroundStyle(AppTheme.pitch)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 14)
            .background(AppTheme.mist)
            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
            .opacity(configuration.isPressed ? 0.88 : 1)
    }
}
