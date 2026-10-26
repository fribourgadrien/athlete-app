import SwiftUI

/// Design tokens — ink on paper, one brand accent used sparingly.
enum AppTheme {
    static let paper = Color(red: 0.965, green: 0.961, blue: 0.953)      // #F6F5F3
    static let ink = Color(red: 0.07, green: 0.07, blue: 0.07)           // #121212
    static let muted = Color(red: 0.42, green: 0.42, blue: 0.41)          // #6B6B69
    static let rule = Color(red: 0.86, green: 0.85, blue: 0.83)           // #DBD9D4
    static let accent = Color(red: 0.09, green: 0.27, blue: 0.20)         // #174533 — CTAs only
    static let surface = Color.white

    // Legacy aliases kept so call sites compile during migration
    static let pitch = accent
    static let pitchDeep = ink
    static let turf = accent
    static let chalk = paper
    static let mist = rule.opacity(0.45)
    static let charcoal = ink
    static let slate = muted
    static let amber = accent
    static let danger = Color(red: 0.55, green: 0.12, blue: 0.10)

    static var backgroundGradient: LinearGradient {
        LinearGradient(colors: [paper, paper], startPoint: .top, endPoint: .bottom)
    }

    static var heroGradient: LinearGradient {
        LinearGradient(colors: [ink, ink], startPoint: .top, endPoint: .bottom)
    }
}

enum AppFont {
    static func display(_ size: CGFloat, weight: Font.Weight = .regular) -> Font {
        .system(size: size, weight: weight, design: .serif)
    }

    static func ui(_ size: CGFloat, weight: Font.Weight = .regular) -> Font {
        .system(size: size, weight: weight, design: .default)
    }
}

struct PrimaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(AppFont.ui(15, weight: .semibold))
            .foregroundStyle(AppTheme.paper)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 14)
            .background(AppTheme.ink)
            .opacity(configuration.isPressed ? 0.75 : 1)
    }
}

struct SecondaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(AppFont.ui(15, weight: .medium))
            .foregroundStyle(AppTheme.ink)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 14)
            .overlay(
                Rectangle()
                    .stroke(AppTheme.rule, lineWidth: 1)
            )
            .opacity(configuration.isPressed ? 0.7 : 1)
    }
}

struct TextLinkButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(AppFont.ui(14, weight: .medium))
            .foregroundStyle(AppTheme.ink)
            .opacity(configuration.isPressed ? 0.5 : 1)
            .underline(true, pattern: .solid, color: AppTheme.rule)
    }
}
