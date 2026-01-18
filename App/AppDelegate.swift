import UIKit
import SwiftUI

@main
final class AppDelegate: PluggableApplicationDelegate {
    var window: UIWindow?

    override func services() -> [ApplicationService] {
        [
//            FirebasePlugin(),
//            NotificationPlugin(),
            WindowPlugin(
                delegate: self,
                rootViewController: UIHostingController(rootView: RootView()),
                isNavigationBarHidden: true
            ),
            LocalizationPlugin(shouldReloadViews: false),
            ThemePlugin(theme: AppTheme()),
            SecurityPlugin(window: window, isRelease: isReleaseMode),
            KeyboardPlugin(),
            RouterPlugin(navigations: [
                LaunchAppNavigation(),
                AuthenticationAppNavigation(),
                HomeNavigation(),
                CustomAlertNavigation(),
                AppGuideNavigation(),
                TrainingNavigation() // ✅ صفحة التدريب الكاملة
                // SettingsNavigation() // ⚠️ سيتم إضافتها بعد إضافة الملف للـ Xcode project
            ])
        ]
    }

    private var isReleaseMode: Bool {
        #if DEBUG
        return false
        #else
        return true
        #endif
    }
}
