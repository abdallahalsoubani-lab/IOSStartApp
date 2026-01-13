import UIKit

final class ThemePlugin: ApplicationService {
    private let theme: AppTheme

    init(theme: AppTheme = AppTheme()) {
        self.theme = theme
    }

    func setupService() {
        setupAppearance()

        #if DEBUG
        print("[ThemePlugin] Theme applied successfully")
        #endif
    }

    private func setupAppearance() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(theme.colors.primary)
        appearance.titleTextAttributes = [
            .foregroundColor: UIColor(theme.colors.onPrimary)
        ]

        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance

        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithOpaqueBackground()
        tabBarAppearance.backgroundColor = UIColor(theme.colors.surface)

        UITabBar.appearance().standardAppearance = tabBarAppearance
        if #available(iOS 15.0, *) {
            UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        }
    }
}
