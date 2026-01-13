# Enterprise iOS Starter Template - Project Manifest

## Complete File Structure & Description

### Project Root Files

```
IOSStartApp/
├── Podfile                          # CocoaPods dependency management
├── .swiftlint.yml                   # SwiftLint configuration
├── swiftgen.yml                     # SwiftGen code generation config
├── README.md                        # Quick start guide
├── SETUP_GUIDE.md                   # Detailed setup instructions
└── PROJECT_MANIFEST.md              # This file
```

---

## App Entry Point

### `App/`
Application initialization and root components.

| File | Purpose |
|------|---------|
| `AppDelegate.swift` | @main entry point; plugin-based initialization |
| `RootView.swift` | SwiftUI root view with navigator & localization |
| `AppEnvironment.swift` | Environment configuration & build info |

---

## Core Infrastructure

### `Core/Plugin/`
Plugin system for modular app lifecycle management.

| File | Purpose |
|------|---------|
| `ApplicationService.swift` | Protocol defining plugin interface |
| `PluggableApplicationDelegate.swift` | Base class for plugin-based AppDelegate |

### `Core/Routing/`
Navigation and routing system.

| File | Purpose |
|------|---------|
| `Route.swift` | AppRoute enum defining all navigation paths |
| `Navigator.swift` | Main navigation controller with route management |
| `Navigations/LaunchAppNavigation.swift` | Launch/splash screen |
| `Navigations/AuthenticationAppNavigation.swift` | Login screen |
| `Navigations/HomeNavigation.swift` | Home screen |
| `Navigations/CustomAlertNavigation.swift` | Custom alert modal |
| `Navigations/AppGuideNavigation.swift` | App guide route registration |

### `Core/Theme/`
Design system and theming.

| File | Purpose |
|------|---------|
| `AppTheme.swift` | Design tokens: colors, typography, spacing, shadows |

### `Core/Localization/`
Internationalization and RTL support.

| File | Purpose |
|------|---------|
| `LocalizationManager.swift` | Language switching, RTL detection, string resources |

### `Core/Networking/`
API client and network error handling.

| File | Purpose |
|------|---------|
| `NetworkError.swift` | Unified network error types with localization |
| `APIClient.swift` | Async/await HTTP client using Alamofire |

### `Core/UIComponents/`
Reusable SwiftUI components.

| File | Purpose |
|------|---------|
| `AppButton.swift` | Button with styles (primary, secondary, outlined, ghost) |
| `AppTextField.swift` | Text field with validation states (error, success, loading) |
| `StateViews.swift` | LoadingView, EmptyStateView, ErrorStateView components |

### `Core/Alert/`
Alert and notification system.

| File | Purpose |
|------|---------|
| `AlertCenter.swift` | Alert management with system & custom alerts |

### `Core/Utilities/`
Extensions and helper functions.

| File | Purpose |
|------|---------|
| `Extensions.swift` | String, Date, Array, View, UserDefaults, Color extensions |

---

## Plugins

All plugins located in `Plugins/`. Each plugin implements `ApplicationService`.

| File | Purpose |
|------|---------|
| `FirebasePlugin.swift` | Firebase initialization & FCM token handling |
| `NotificationPlugin.swift` | Push notification setup & handling |
| `WindowPlugin.swift` | UIWindow setup & root view controller |
| `KeyboardPlugin.swift` | IQKeyboardManagerSwift configuration |
| `LocalizationPlugin.swift` | Localization setup (RTL, semantic attributes) |
| `ThemePlugin.swift` | UIAppearance configuration (nav bar, tab bar) |
| `SecurityPlugin.swift` | Security measures (screenshot prevention) |
| `RouterPlugin.swift` | Navigation system initialization |

---

## Features

### `Features/AppGuide/`
In-app component catalog and documentation.

| File | Purpose |
|------|---------|
| `AppGuideView.swift` | Live documentation with component examples |

---

## Configuration Files

### `Targets/Shared/Configurations/`
Shared xcconfig files inherited by all targets.

| File | Purpose |
|------|---------|
| `Base.xcconfig` | Foundation settings (iOS 17, Swift 5.10, team ID) |
| `Debug.xcconfig` | Debug environment settings |
| `Release.xcconfig` | Release/production settings |
| `Staging.xcconfig` | Staging/QA settings |

### `Targets/YGB/Configurations/`
YGB flavor-specific configurations.

| File | Purpose |
|------|---------|
| `YGB-Application.xcconfig` | YGB app constants (bundle ID, API URLs, bank code) |
| `YGB-Debug.xcconfig` | YGB + Debug configuration |
| `YGB-Release.xcconfig` | YGB + Release configuration |
| `YGB-Staging.xcconfig` | YGB + Staging configuration |

### `Targets/DEMO/Configurations/`
DEMO flavor-specific configurations (mirror of YGB).

| File | Purpose |
|------|---------|
| `DEMO-Application.xcconfig` | DEMO app constants |
| `DEMO-Debug.xcconfig` | DEMO + Debug configuration |
| `DEMO-Release.xcconfig` | DEMO + Release configuration |
| `DEMO-Staging.xcconfig` | DEMO + Staging configuration |

### `Targets/YGB/`
YGB flavor Firebase configuration.

| File | Purpose |
|------|---------|
| `GoogleService-Info.plist` | Firebase config (placeholder) |

### `Targets/DEMO/`
DEMO flavor Firebase configuration.

| File | Purpose |
|------|---------|
| `GoogleService-Info.plist` | Firebase config (placeholder) |

---

## Resources

### `Resources/Localization/`
Localization files for Arabic and English.

| File | Purpose |
|------|---------|
| `en.lproj/Localizable.strings` | English string resources (~50 keys) |
| `ar.lproj/Localizable.strings` | Arabic string resources (~50 keys) |

### `Resources/`

| File | Purpose |
|------|---------|
| `Info.plist` | App configuration with xcconfig variables |

---

## Build Configuration Files

| File | Purpose |
|------|---------|
| `Podfile` | CocoaPods dependencies (Alamofire, Firebase, etc.) |
| `.swiftlint.yml` | SwiftLint rules (disabled rules, thresholds) |
| `swiftgen.yml` | SwiftGen code generation (strings, assets) |

---

## Total Files Summary

| Category | Count |
|----------|-------|
| Swift Source Files | 41 |
| xcconfig Files | 12 |
| Localization Files | 2 |
| Plist Files | 3 |
| Configuration Files | 4 |
| Documentation | 3 |
| **Total** | **65** |

---

## File Count by Module

```
App/                          3 files
Core/Plugin/                  2 files
Core/Routing/                 7 files
Core/Theme/                   1 file
Core/Localization/            1 file
Core/Networking/              2 files
Core/UIComponents/            3 files
Core/Alert/                   1 file
Core/Utilities/               1 file
Plugins/                      8 files
Features/AppGuide/            1 file
Targets/Shared/Configurations/ 4 files
Targets/YGB/Configurations/   4 files
Targets/DEMO/Configurations/  4 files
Targets/YGB/                  1 file
Targets/DEMO/                 1 file
Resources/Localization/       2 files
Resources/                    1 file
Root/                         4 files
```

---

## Key Design Decisions

### 1. Plugin System
- Modular initialization
- Decoupled concerns
- Easy to add/remove features
- Reusable plugin architecture

### 2. XCConfig Hierarchy
- Base config for shared settings
- Environment-specific overrides (Debug/Release/Staging)
- Flavor-specific constants (YGB/DEMO)
- Configuration composition pattern

### 3. MVVM + Router
- Views are presentation-only
- Navigation logic in Router
- ViewModels for business logic
- Type-safe route navigation

### 4. Theme System
- Design tokens as values
- Environment injection
- Easy brand customization
- Runtime theme switching ready

### 5. Localization
- Separate files per language
- String extension for convenience
- SwiftGen for type safety
- Runtime language switching supported

---

## Getting Started

1. **Read**: `README.md` for quick overview
2. **Follow**: `SETUP_GUIDE.md` for detailed setup
3. **Run**: `pod install` then open `.xcworkspace`
4. **Explore**: Open AppGuideView in the app to see all components
5. **Configure**: Update xcconfig files for your flavor

---

## Architecture Layers

```
UI Layer (SwiftUI)
   ↓
Router/Coordinator
   ↓
ViewModel (Business Logic)
   ↓
Model (Data)
   ↓
Repository/API Client
   ↓
Networking (Alamofire)
```

---

## Plugin Initialization Order

```
1. FirebasePlugin              → Setup Firebase
2. NotificationPlugin          → Request push permissions
3. WindowPlugin               → Create UI window
4. LocalizationPlugin         → Setup RTL/localization
5. ThemePlugin                → Apply visual theme
6. SecurityPlugin             → Apply security measures
7. KeyboardPlugin             → Setup keyboard manager
8. RouterPlugin               → Register navigation routes
```

---

## Component Relationships

```
AppDelegate
    ├── Plugins (8 total)
    │   └── RouterPlugin
    │       └── Navigations (5 total)
    │           ├── LaunchNavigation
    │           ├── AuthenticationNavigation
    │           ├── HomeNavigation
    │           ├── CustomAlertNavigation
    │           └── AppGuideNavigation
    └── RootView
        ├── Navigator (ObservedObject)
        ├── LocalizationManager (ObservedObject)
        └── AppTheme (Environment)

AppGuideView
    ├── SectionView (theme preview)
    ├── AppButton (multiple styles)
    ├── AppTextField (multiple states)
    ├── State Views (loading, empty, error)
    ├── Alerts Demo
    ├── Localization Demo
    ├── Router Demo
    └── Firebase Status
```

---

## Configuration Variables Available

### Common (Base.xcconfig)
- `IPHONEOS_DEPLOYMENT_TARGET` = 17.0
- `SWIFT_VERSION` = 5.10
- `APP_NAME` = Enterprise iOS App
- `CLIENT_NAME` = Client Name

### Per-Flavor
- `FLAVOR` = YGB or DEMO
- `APP_DISPLAY_NAME` = Display name
- `APP_IDENTIFIER` = Bundle ID
- `TEAM_ID` = Development team
- `BANK_CODE` = Client bank code
- `CONFIG_KEY` = Configuration key
- `API_BASE_URL` = API endpoint

### Per-Environment
- `API_ENVIRONMENT` = development/staging/production
- `LOG_LEVEL` = verbose/debug/error
- `ENABLE_NETWORK_LOGGING` = YES/NO
- `SECURITY_CERTIFICATE_PINNING_ENABLED` = YES/NO

---

## Code Quality Tools

### SwiftLint
- Configured in `.swiftlint.yml`
- Runs automatically via build phase
- Enforces code style and best practices
- Can be run manually: `swiftlint`

### SwiftGen
- Configured in `swiftgen.yml`
- Generates type-safe string resources
- Generates image catalog references
- Runs automatically via build phase
- Output: `Generated/L10n.swift`, `Generated/Assets.swift`

---

## Dependencies Summary

| Package | Version | Purpose |
|---------|---------|---------|
| Alamofire | ~5.9 | HTTP networking |
| PromiseKit | ~6.23 | Promise-based async |
| Firebase/Core | ~11.0 | Analytics |
| Firebase/Messaging | ~11.0 | Push notifications |
| IQKeyboardManagerSwift | ~3.3 | Keyboard management |
| SwiftLint | ~0.56 | Code linting |

---

## Testing Strategy

- SwiftUI Previews included in all Views
- Component examples in AppGuideView
- Manual testing across flavors
- Configuration testing via xcconfig

---

## Deployment Checklist

Before submission:
- [ ] Update version in Base.xcconfig
- [ ] Configure Firebase GoogleService-Info.plist
- [ ] Review all xcconfig values (Team ID, Bundle ID, etc.)
- [ ] Test all flavors and configurations
- [ ] Verify localization (English & Arabic)
- [ ] Test push notifications
- [ ] Run SwiftLint (`swiftlint`)
- [ ] Check code signing

---

## Documentation Files

| File | Contents |
|------|----------|
| `README.md` | Quick start and feature overview |
| `SETUP_GUIDE.md` | Step-by-step setup and configuration |
| `PROJECT_MANIFEST.md` | This file - detailed file structure |

---

**Template Version**: 1.0
**Swift Version**: 5.10+
**iOS Minimum**: 17.0
**Status**: Production Ready ✅
