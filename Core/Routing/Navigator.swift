import SwiftUI

protocol AppNavigation: AnyObject {
    func registerRoutes(_ navigator: Navigator)
}

@MainActor
final class Navigator: ObservableObject {
    @Published var navigationPath: NavigationPath = NavigationPath()
    @Published var presentedRoute: AppRoute?
    @Published var sheetRoute: AppRoute?

    private var routeMap: [String: (Navigator) -> AnyView] = [:]

    func registerRoute(_ path: String, builder: @escaping (Navigator) -> AnyView) {
        routeMap[path] = builder
    }

    func navigate(to route: AppRoute) {
        navigationPath.append(route)
    }

    func navigate(to path: String) {
        if let route = AppRoute(rawValue: path) {
            navigate(to: route)
        }
    }

    func present(_ route: AppRoute) {
        presentedRoute = route
    }

    func presentSheet(_ route: AppRoute) {
        sheetRoute = route
    }

    func dismiss() {
        presentedRoute = nil
    }

    func dismissSheet() {
        sheetRoute = nil
    }

    func pop() {
        navigationPath.removeLast()
    }

    func popToRoot() {
        navigationPath = NavigationPath()
    }

    func viewForRoute(_ route: AppRoute) -> AnyView? {
        routeMap[route.id]?(self)
    }
}

// MARK: - AppRoute Extension

extension AppRoute {
    init?(rawValue: String) {
        guard let path = Path(rawValue: rawValue) else { return nil }
        self.init(path: path)
    }
}
