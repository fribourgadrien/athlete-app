import SwiftUI

/// Design tokens inspired by White & Case 2026 identity:
/// electric cobalt + near-black + paper. Cobalt used sparingly for brand signal / CTAs.
enum AppTheme {
    /// #2611C9 — brand cobalt (hero fields, primary actions)
    static let cobalt = Color(red: 0.149, green: 0.067, blue: 0.788)
    /// #1B1B1B
    static let ink = Color(red: 0.106, green: 0.106, blue: 0.106)
    /// #F4F4F4
    static let paper = Color(red: 0.957, green: 0.957, blue: 0.957)
    /// #707279
    static let muted = Color(red: 0.439, green: 0.447, blue: 0.475)
    /// #DADADA
    static let rule = Color(red: 0.855, green: 0.855, blue: 0.855)
    static let surface = Color.white
    /// Soft tint for selected filter underline / quiet chrome
    static let cobaltWash = Color(red: 0.945, green: 0.941, blue: 1.0) // ~#F1F0FF

    static let accent = cobalt
    static let pitch = cobalt
    static let pitchDeep = ink
    static let turf = cobalt
    static let chalk = paper
    static let mist = rule.opacity(0.55)
    static let charcoal = ink
    static let slate = muted
    static let amber = cobalt
    static let danger = Color(red: 0.55, green: 0.12, blue: 0.10)

    static var backgroundGradient: LinearGradient {
        LinearGradient(colors: [paper, paper], startPoint: .top, endPoint: .bottom)
    }

    static var heroGradient: LinearGradient {
        LinearGradient(colors: [cobalt, cobalt], startPoint: .top, endPoint: .bottom)
    }
}

enum AppFont {
    static func display(_ size: CGFloat, weight: Font.Weight = .regular) -> Font {
        .system(size: size, weight: weight, design: .serif)
    }

    static func displayItalic(_ size: CGFloat, weight: Font.Weight = .regular) -> Font {
        // Serif italic as intentional accent (W&C-style), not decoration noise
        .system(size: size, weight: weight, design: .serif).italic()
    }

    static func ui(_ size: CGFloat, weight: Font.Weight = .regular) -> Font {
        .system(size: size, weight: weight, design: .default)
    }

    static func label(_ size: CGFloat = 11) -> Font {
        .system(size: size, weight: .semibold, design: .default)
    }
}

struct PrimaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(AppFont.ui(15, weight: .semibold))
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 14)
            .background(AppTheme.cobalt)
            .opacity(configuration.isPressed ? 0.78 : 1)
    }
}

struct SecondaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(AppFont.ui(15, weight: .medium))
            .foregroundStyle(AppTheme.ink)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 14)
            .background(AppTheme.surface)
            .overlay(Rectangle().stroke(AppTheme.rule, lineWidth: 1))
            .opacity(configuration.isPressed ? 0.7 : 1)
    }
}

struct TextLinkButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(AppFont.ui(14, weight: .medium))
            .foregroundStyle(AppTheme.cobalt)
            .opacity(configuration.isPressed ? 0.5 : 1)
    }
}
