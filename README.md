# Enterprise iOS SwiftUI Starter Template

A production-ready, standards-based iOS application template for enterprise development featuring MVVM architecture, plugin-based AppDelegate, multi-flavor support, and comprehensive design system.

## ✨ Features

### Architecture & Design
- **MVVM Pattern** - Clean separation of concerns
- **Plugin-based AppDelegate** - Modular application initialization
- **Coordinator/Router Pattern** - Type-safe navigation
- **Design System** - Theme tokens, colors, typography, spacing

### Multi-Flavor Support
- **YGB & DEMO Flavors** - Pre-configured example flavors
- **xcconfig Files** - Build configuration management
- **Per-Flavor Settings** - Bundle IDs, API endpoints, constants
- **Easy Flavor Expansion** - Step-by-step guide included

### Localization & Internationalization
- **Arabic & English** - Fully localized strings
- **RTL Support** - Right-to-left layout support
- **Runtime Language Switching** - Change language without restart
- **SwiftGen Integration** - Type-safe string resources

### UI & Components
- **SwiftUI First** - Modern UI framework
- **AppButton** - Multiple styles (primary, secondary, outlined, ghost)
- **AppTextField** - State management (normal, error, success, loading)
- **State Views** - Loading, Empty, Error state screens
- **AppGuideView** - In-app component catalog & documentation

### Networking & APIs
- **Async/Await** - Modern concurrency
- **Alamofire Integration** - HTTP client
- **PromiseKit Support** - Promise-based async
- **Error Handling** - Unified NetworkError mapping
- **Request Logging** - DEBUG-only request/response logging

### Firebase Integration
- **Firebase Messaging** - Push notifications
- **Firebase Core** - Analytics ready
- **Plugin-based Setup** - Easy configuration

## 🚀 Quick Start

### 1. Install Dependencies
```bash
pod install
open IOSStartApp.xcworkspace
```

### 2. Select Flavor & Configuration
- **Scheme**: YGB-Debug, YGB-Release, YGB-Staging
- or **Scheme**: DEMO-Debug, DEMO-Release, DEMO-Staging

### 3. Build & Run
```bash
xcodebuild -workspace IOSStartApp.xcworkspace \
  -scheme YGB-Debug \
  -configuration Debug
```

## 📁 Project Structure

```
IOSStartApp/
├── App/                          # App entry point
│   ├── AppDelegate.swift         # Plugin system initialization
│   ├── RootView.swift            # Root SwiftUI view
│   └── AppEnvironment.swift      # Configuration
├── Core/                         # Core modules
│   ├── Plugin/                   # Plugin system
│   ├── Routing/                  # Navigation system
│   ├── Theme/                    # Design tokens
│   ├── Localization/             # i18n manager
│   ├── Networking/               # API client
│   ├── UIComponents/             # Reusable components
│   ├── Alert/                    # Alert system
│   └── Utilities/                # Extensions & helpers
├── Plugins/                      # Plugin implementations
├── Features/                     # Feature modules
├── Resources/                    # Localization & assets
└── Targets/                      # Build configurations
    ├── Shared/                   # Shared xcconfig
    ├── YGB/                      # YGB flavor
    └── DEMO/                     # DEMO flavor
```

## 🎨 Key Components

### AppTheme (Design Tokens)
```swift
@Environment(\.appTheme) var theme

VStack(spacing: theme.spacing.md) {
    Text("Title")
        .font(theme.typography.titleLarge)
        .foregroundColor(theme.colors.primary)
}
```

### Networking
```swift
let result: MyModel = try await APIClient.shared.request("endpoint")
```

### Localization
```swift
LocalizationManager.shared.setLanguage(.arabic)
Text("app_name".localized())
```

### Navigation
```swift
navigator.navigate(to: AppRoute(path: .home))
navigator.presentSheet(AppRoute(path: .customAlert))
```

## 📚 Documentation

- **SETUP_GUIDE.md** - Detailed setup and configuration instructions
- **AppGuideView** - In-app living documentation (open from Home)
- **Component Examples** - See all button styles, text fields, states

## 🔧 Configuration

All configuration is managed via **xcconfig files**:
- `Targets/Shared/Configurations/` - Shared settings
- `Targets/YGB/Configurations/` - YGB flavor settings
- `Targets/DEMO/Configurations/` - DEMO flavor settings

## 📝 File Naming

- Views: `*View.swift`
- Navigations: `*Navigation.swift`
- Plugins: `*Plugin.swift`
- Extensions: `Extensions.swift`

## 🚀 Ready to Deploy

This template is production-ready:
- ✅ Xcode 15+ compatible
- ✅ iOS 17.0+ support
- ✅ Swift 5.10+
- ✅ Multi-flavor support
- ✅ Secure configuration

---

**For detailed setup instructions, see SETUP_GUIDE.md**