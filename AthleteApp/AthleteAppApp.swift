import SwiftUI

@main
struct AthleteAppApp: App {
    @StateObject private var store = AppStore()

    init() {
        AppTypography.configureNavigationChrome()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(store)
                .preferredColorScheme(.light)
        }
    }
}
