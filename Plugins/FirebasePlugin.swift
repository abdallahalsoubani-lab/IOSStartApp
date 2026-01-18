import Foundation
import FirebaseCore
import FirebaseMessaging

final class FirebasePlugin: NSObject, ApplicationService {
    static let shared = FirebasePlugin()

    func setupService() {
        // Check if GoogleService-Info.plist exists
        guard let _ = Bundle.main.path(forResource: "GoogleService-Info", ofType: "plist") else {
            #if DEBUG
            print("[FirebasePlugin] ⚠️ GoogleService-Info.plist not found. Firebase not initialized.")
            print("[FirebasePlugin] Please add a valid GoogleService-Info.plist to your project.")
            #endif
            return
        }
        
        FirebaseApp.configure()
        Messaging.messaging().delegate = self

        #if DEBUG
        print("[FirebasePlugin] ✅ Firebase initialized successfully")
        #endif
    }

    func applicationDidBecomeActive() {
        // Handle push notifications if needed
    }
}

// MARK: - MessagingDelegate

extension FirebasePlugin: MessagingDelegate {
    func messaging(
        _ messaging: Messaging,
        didReceiveRegistrationToken fcmToken: String?
    ) {
        #if DEBUG
        print("[FirebasePlugin] FCM Token: \(fcmToken ?? "nil")")
        #endif

        // Store token or send to server
        if let token = fcmToken {
            UserDefaults.standard.set(token, forKey: "fcm_token")
        }
    }
}
