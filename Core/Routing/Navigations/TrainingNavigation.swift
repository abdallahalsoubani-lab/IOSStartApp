import SwiftUI

// MARK: - Training Navigation
// ========================================
// تسجيل صفحة التدريب في نظام الـ Navigation

class TrainingNavigation: AppNavigation {
    func registerRoutes(_ navigator: Navigator) {
        // تسجيل الـ Route: "training"
        navigator.registerRoute("training") { navigator in
            AnyView(TrainingView(navigator: navigator))
        }
    }
}
