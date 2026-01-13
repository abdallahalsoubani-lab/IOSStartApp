import Foundation
import Combine

final class LocalizationManager: ObservableObject {
    static let shared = LocalizationManager()

    @Published var currentLanguage: Language = .english
    @Published var isRTL: Bool = false

    private var observers: [NSObjectProtocol] = []

    enum Language: String, CaseIterable {
        case english = "en"
        case arabic = "ar"

        var displayName: String {
            switch self {
            case .english:
                return "English"
            case .arabic:
                return "العربية"
            }
        }
    }

    init() {
        setupLanguage()
    }

    private func setupLanguage() {
        let preferredLanguage = UserDefaults.standard.string(forKey: "app_language") ?? Language.english.rawValue

        if let language = Language(rawValue: preferredLanguage) {
            setLanguage(language)
        } else {
            setLanguage(.english)
        }
    }

    func setLanguage(_ language: Language) {
        currentLanguage = language
        isRTL = language == .arabic

        UserDefaults.standard.set(language.rawValue, forKey: "app_language")
        UserDefaults.standard.set(isRTL, forKey: "isRTL")
        UserDefaults.standard.synchronize()

        updateLocaleAndDirection()

        #if DEBUG
        print("[LocalizationManager] Language changed to: \(language.displayName), RTL: \(isRTL)")
        #endif
    }

    private func updateLocaleAndDirection() {
        let locale = Locale(identifier: currentLanguage.rawValue)
        UserDefaults.standard.set([currentLanguage.rawValue], forKey: "AppleLanguages")

        if #available(iOS 17.0, *) {
            if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                scene.windows.forEach { window in
                    window.overrideUserInterfaceStyle = .none
                    window.semanticContentAttribute = isRTL ? .forceRightToLeft : .forceLeftToRight
                }
            }
        }
    }

    deinit {
        observers.forEach { NotificationCenter.default.removeObserver($0) }
    }
}

// MARK: - String Extension for Localization

extension String {
    func localized() -> String {
        let language = LocalizationManager.shared.currentLanguage.rawValue
        guard let path = Bundle.main.path(forResource: language, ofType: "lproj"),
              let bundle = Bundle(path: path) else {
            return self
        }

        return NSLocalizedString(self, bundle: bundle, comment: "")
    }

    func localized(with arguments: CVarArg...) -> String {
        let translated = self.localized()
        return String(format: translated, arguments: arguments)
    }
}
