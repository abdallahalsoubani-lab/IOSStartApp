import SwiftUI

class HomeNavigation: AppNavigation {
    func registerRoutes(_ navigator: Navigator) {
        navigator.registerRoute("home") { navigator in
            AnyView(HomeScreenView(navigator: navigator))
        }
    }
}

struct HomeScreenView: View {
    @ObservedObject var navigator: Navigator
    @Environment(\.appTheme) var theme

    var body: some View {
        NavigationStack(path: $navigator.navigationPath) {
            VStack(spacing: theme.spacing.lg) {
                Text("Home Screen")
                    .font(theme.typography.headlineLarge)
                    .foregroundColor(theme.colors.onBackground)

                VStack(spacing: theme.spacing.md) {
                    Button(action: {
                        navigator.navigate(to: AppRoute(path: .appGuide))
                    }) {
                        Text("Open App Guide / Components Catalog")
                            .frame(maxWidth: .infinity)
                            .padding(theme.spacing.md)
                            .background(theme.colors.primary)
                            .foregroundColor(theme.colors.onPrimary)
                            .cornerRadius(8)
                    }

                    Button(action: {
                        navigator.presentSheet(AppRoute(path: .customAlert))
                    }) {
                        Text("Show Custom Alert")
                            .frame(maxWidth: .infinity)
                            .padding(theme.spacing.md)
                            .background(theme.colors.secondary)
                            .foregroundColor(theme.colors.onSecondary)
                            .cornerRadius(8)
                    }

                    Button(action: {
                        print("Settings tapped")
                    }) {
                        Text("Settings")
                            .frame(maxWidth: .infinity)
                            .padding(theme.spacing.md)
                            .background(theme.colors.surfaceVariant)
                            .foregroundColor(theme.colors.onSurface)
                            .cornerRadius(8)
                    }
                }
                .padding(theme.spacing.md)

                Spacer()

                Text("Welcome to the Enterprise iOS Template")
                    .font(theme.typography.bodySmall)
                    .foregroundColor(theme.colors.onBackground.opacity(0.6))
                    .multilineTextAlignment(.center)
                    .padding(theme.spacing.md)
            }
            .padding(theme.spacing.lg)
            .navigationDestination(for: AppRoute.self) { route in
                if let view = navigator.viewForRoute(route) {
                    view
                }
            }
        }
    }
}

#Preview {
    HomeScreenView(navigator: Navigator())
        .appTheme(AppTheme())
}
