import UIKit

final class RouterPlugin: ApplicationService {
    private let navigations: [AppNavigation]
    private(set) var navigator: Navigator?

    init(navigations: [AppNavigation] = []) {
        self.navigations = navigations
    }

    func setupService() {
        let navigator = Navigator()

        for navigation in navigations {
            navigation.registerRoutes(navigator)
        }

        self.navigator = navigator

        #if DEBUG
        print("[RouterPlugin] Router initialized with \(navigations.count) navigation(s)")
        #endif
    }

    static let shared: RouterPlugin? = nil
}
