import UIKit

final class LocalizationPlugin: ApplicationService {
    private let shouldReloadViews: Bool

    init(shouldReloadViews: Bool = false) {
        self.shouldReloadViews = shouldReloadViews
    }

    func setupService() {
        let localizationManager = LocalizationManager.shared

        let isRTL = localizationManager.isRTL
        UIView.setAnimationsEnabled(false)

        if let window = UIApplication.shared.windows.first {
            window.semanticContentAttribute = isRTL ? .forceRightToLeft : .forceLeftToRight
        }

        UIView.setAnimationsEnabled(true)

        #if DEBUG
        print("[LocalizationPlugin] Localization setup completed. RTL: \(isRTL)")
        #endif
    }
}
