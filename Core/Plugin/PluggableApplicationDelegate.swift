import UIKit

open class PluggableApplicationDelegate: UIResponder, UIApplicationDelegate {
    private(set) var registeredServices: [ApplicationService] = []

    open func services() -> [ApplicationService] {
        []
    }

    // MARK: - Lifecycle Methods

    public func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        setupServices()
        return true
    }

    public func applicationDidBecomeActive(_ application: UIApplication) {
        registeredServices.forEach { $0.applicationDidBecomeActive() }
    }

    public func applicationWillResignActive(_ application: UIApplication) {
        registeredServices.forEach { $0.applicationWillResignActive() }
    }

    public func applicationWillTerminate(_ application: UIApplication) {
        registeredServices.forEach { $0.applicationWillTerminate() }
    }

    // MARK: - Private Methods

    private func setupServices() {
        registeredServices = services()
        registeredServices.forEach { $0.setupService() }
    }
}
