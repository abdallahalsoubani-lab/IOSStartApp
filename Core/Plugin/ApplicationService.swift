import Foundation

/// Protocol that defines a service that can be plugged into the app lifecycle
protocol ApplicationService: AnyObject {
    /// Called when the service should initialize
    func setupService()

    /// Called when the app becomes active
    func applicationDidBecomeActive()

    /// Called when the app will resign active
    func applicationWillResignActive()

    /// Called when the app is about to terminate
    func applicationWillTerminate()
}

/// Default implementation with empty methods
extension ApplicationService {
    func setupService() {}
    func applicationDidBecomeActive() {}
    func applicationWillResignActive() {}
    func applicationWillTerminate() {}
}
