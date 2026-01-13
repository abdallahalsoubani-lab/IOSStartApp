import UIKit

final class WindowPlugin: ApplicationService {
    var window: UIWindow?

    private let delegate: UIApplicationDelegate
    private let rootViewController: UIViewController
    private let isNavigationBarHidden: Bool

    init(
        delegate: UIApplicationDelegate,
        rootViewController: UIViewController,
        isNavigationBarHidden: Bool = false
    ) {
        self.delegate = delegate
        self.rootViewController = rootViewController
        self.isNavigationBarHidden = isNavigationBarHidden
    }

    func setupService() {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
        self.window = window

        #if DEBUG
        print("[WindowPlugin] Window created and root view controller set")
        #endif
    }

    func setRootViewController(_ viewController: UIViewController, animated: Bool = true) {
        guard let window = window else { return }

        if animated {
            UIView.transition(
                with: window,
                duration: 0.3,
                options: .transitionCrossDissolve,
                animations: {
                    window.rootViewController = viewController
                }
            )
        } else {
            window.rootViewController = viewController
        }
    }
}
