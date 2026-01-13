import SwiftUI

class AppGuideNavigation: AppNavigation {
    func registerRoutes(_ navigator: Navigator) {
        navigator.registerRoute("app-guide") { navigator in
            AnyView(AppGuideView(navigator: navigator))
        }
    }
}
