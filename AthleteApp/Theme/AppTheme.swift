import SwiftUI
import UIKit

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

/// Type pairing inspired by W&C custom stack (serif headline + institutional sans).
/// Bundled: Source Serif 4 (display) + IBM Plex Sans (UI) — not a clone of proprietary WC faces.
enum AppFont {
    static func display(_ size: CGFloat, weight: Font.Weight = .regular) -> Font {
        .custom(serifName(for: weight), size: size)
    }

    static func displayItalic(_ size: CGFloat, weight: Font.Weight = .regular) -> Font {
        // Dedicated italic cut — W&C-style intentional italic accent
        .custom("SourceSerif4-Italic", size: size)
    }

    static func ui(_ size: CGFloat, weight: Font.Weight = .regular) -> Font {
        .custom(sansName(for: weight), size: size)
    }

    static func label(_ size: CGFloat = 11) -> Font {
        .custom("IBMPlexSans-SemiBold", size: size)
    }

    static func uiKitSerif(size: CGFloat, weight: Font.Weight = .bold) -> UIFont {
        UIFont(name: serifName(for: weight), size: size)
            ?? .systemFont(ofSize: size, weight: .bold)
    }

    static func uiKitSans(size: CGFloat, weight: Font.Weight = .medium) -> UIFont {
        UIFont(name: sansName(for: weight), size: size)
            ?? .systemFont(ofSize: size, weight: .medium)
    }

    private static func serifName(for weight: Font.Weight) -> String {
        switch weight {
        case .bold, .heavy, .black:
            return "SourceSerif4-Bold"
        case .semibold, .medium:
            return "SourceSerif4-SemiBold"
        default:
            return "SourceSerif4-Regular"
        }
    }

    private static func sansName(for weight: Font.Weight) -> String {
        switch weight {
        case .bold, .heavy, .black:
            return "IBMPlexSans-Bold"
        case .semibold:
            return "IBMPlexSans-SemiBold"
        case .medium:
            return "IBMPlexSans-Medium"
        default:
            return "IBMPlexSans-Regular"
        }
    }
}

enum AppTypography {
    /// Apply brand fonts to system navigation chrome once at launch.
    static func configureNavigationChrome() {
        let paper = UIColor(AppTheme.paper)
        let ink = UIColor(AppTheme.ink)

        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = paper
        appearance.shadowColor = UIColor(AppTheme.rule)
        appearance.largeTitleTextAttributes = [
            .font: AppFont.uiKitSerif(size: 34, weight: .bold),
            .foregroundColor: ink
        ]
        appearance.titleTextAttributes = [
            .font: AppFont.uiKitSans(size: 17, weight: .medium),
            .foregroundColor: ink
        ]

        let nav = UINavigationBar.appearance()
        nav.standardAppearance = appearance
        nav.scrollEdgeAppearance = appearance
        nav.compactAppearance = appearance
        nav.tintColor = UIColor(AppTheme.cobalt)

        let tab = UITabBarAppearance()
        tab.configureWithOpaqueBackground()
        tab.backgroundColor = paper
        tab.shadowColor = UIColor(AppTheme.rule)
        let item = UITabBarItemAppearance()
        let tabFont = AppFont.uiKitSans(size: 10, weight: .medium)
        item.normal.titleTextAttributes = [
            .font: tabFont,
            .foregroundColor: UIColor(AppTheme.muted)
        ]
        item.selected.titleTextAttributes = [
            .font: tabFont,
            .foregroundColor: UIColor(AppTheme.cobalt)
        ]
        tab.stackedLayoutAppearance = item
        tab.inlineLayoutAppearance = item
        tab.compactInlineLayoutAppearance = item

        let tabBar = UITabBar.appearance()
        tabBar.standardAppearance = tab
        tabBar.scrollEdgeAppearance = tab
        tabBar.tintColor = UIColor(AppTheme.cobalt)
        tabBar.unselectedItemTintColor = UIColor(AppTheme.muted)
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
