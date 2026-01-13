import UIKit
import UserNotifications

final class NotificationPlugin: NSObject, ApplicationService, UNUserNotificationCenterDelegate {
    static let shared = NotificationPlugin()

    func setupService() {
        UNUserNotificationCenter.current().delegate = self
        requestNotificationPermission()
    }

    private func requestNotificationPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            #if DEBUG
            print("[NotificationPlugin] Notification permission: \(granted ? "granted" : "denied")")
            if let error = error {
                print("[NotificationPlugin] Error: \(error.localizedDescription)")
            }
            #endif

            DispatchQueue.main.async {
                UIApplication.shared.registerForRemoteNotifications()
            }
        }
    }

    // MARK: - UNUserNotificationCenterDelegate

    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void
    ) {
        #if DEBUG
        print("[NotificationPlugin] Received notification in foreground: \(notification.request.content.body)")
        #endif

        completionHandler([.banner, .sound, .badge])
    }

    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        didReceive response: UNNotificationResponse,
        withCompletionHandler completionHandler: @escaping () -> Void
    ) {
        #if DEBUG
        print("[NotificationPlugin] User tapped notification: \(response.notification.request.content.body)")
        #endif

        completionHandler()
    }
}
