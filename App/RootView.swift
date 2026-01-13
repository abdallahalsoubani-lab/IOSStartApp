import SwiftUI

struct RootView: View {
    @StateObject private var navigator = Navigator()
    @StateObject private var localizationManager = LocalizationManager.shared
    @Environment(\.appTheme) var theme
    @State private var isInitialized = false

    var body: some View {
        ZStack {
            NavigationStack(path: $navigator.navigationPath) {
                LaunchScreenView(navigator: navigator)
                    .navigationDestination(for: AppRoute.self) { route in
                        if let view = navigator.viewForRoute(route) {
                            view
                        }
                    }
            }

            if let presentedRoute = navigator.presentedRoute {
                if let view = navigator.viewForRoute(presentedRoute) {
                    view
                        .transition(.opacity)
                }
            }
        }
        .sheet(item: $navigator.sheetRoute) { route in
            if let view = navigator.viewForRoute(route) {
                view
            }
        }
        .environmentObject(navigator)
        .environmentObject(localizationManager)
        .appTheme(AppTheme())
        .onAppear {
            if !isInitialized {
                setupApp()
                isInitialized = true
            }
        }
    }

    private func setupApp() {
        #if DEBUG
        print("[RootView] App initialized")
        #endif
    }
}

#Preview {
    RootView()
}
