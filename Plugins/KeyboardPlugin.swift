import UIKit
import IQKeyboardManagerSwift

final class KeyboardPlugin: ApplicationService {
    func setupService() {
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        IQKeyboardManager.shared.shouldShowToolbarPlaceholder = false
        IQKeyboardManager.shared.enableAutoToolbar = true

        #if DEBUG
        print("[KeyboardPlugin] IQKeyboardManager configured")
        #endif
    }
}
