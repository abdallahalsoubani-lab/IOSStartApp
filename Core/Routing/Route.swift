import SwiftUI

protocol Route: Hashable, Identifiable {
    var id: String { get }
}

struct AppRoute: Route {
    enum Path: String {
        case launch = "launch"
        case login = "login"
        case home = "home"
        case customAlert = "custom-alert"
        case appGuide = "app-guide"
        case settings = "settings" // مثال: صفحة Settings
        case training = "training" // صفحة التدريب - تحتوي على كل الأمثلة
    }

    let path: Path

    var id: String {
        path.rawValue
    }

    static func == (lhs: AppRoute, rhs: AppRoute) -> Bool {
        lhs.path == rhs.path
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(path)
    }
}
