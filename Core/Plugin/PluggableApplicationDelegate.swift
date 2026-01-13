import UIKit

open class PluggableApplicationDelegate: UIResponder, UIApplicationDelegate {
    private(set) var services: [ApplicationService] = []

    open func services() -> [ApplicationService] {
        []
    }

    // MARK: - Lifecycle Methods

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        setupServices()
        return true
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        services.forEach { $0.applicationDidBecomeActive() }
    }

    func applicationWillResignActive(_ application: UIApplication) {
        services.forEach { $0.applicationWillResignActive() }
    }

    func applicationWillTerminate(_ application: UIApplication) {
        services.forEach { $0.applicationWillTerminate() }
    }

    // MARK: - Private Methods

    private func setupServices() {
        services = services()
        services.forEach { $0.setupService() }
    }
}
