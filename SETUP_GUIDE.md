# Enterprise iOS SwiftUI Starter Template - Setup Guide

A production-ready iOS application template with MVVM architecture, plugin-based AppDelegate, flavor support, and comprehensive design system.

## Prerequisites

- Xcode 15+
- iOS 17.0+
- Swift 5.10+
- CocoaPods 1.14+

## Quick Start

### 1. Install Dependencies

```bash
pod install
open IOSStartApp.xcworkspace
```

### 2. Configure Build Settings

#### For Xcode Project Setup

1. In Xcode, select the project **IOSStartApp**
2. For each flavor target (YGB, DEMO):
   - Select **Build Settings**
   - Search for "XCConfig"
   - Set the following for each configuration:
     - **Debug**: `Targets/YGB/Configurations/YGB-Debug.xcconfig`
     - **Release**: `Targets/YGB/Configurations/YGB-Release.xcconfig`
     - **Staging**: `Targets/YGB/Configurations/YGB-Staging.xcconfig`
   - Repeat for DEMO flavor

3. For **Info.plist**, link it to each target with xcconfig variables

#### XCConfig Hierarchy

```
Base.xcconfig (Shared settings for all targets)
├── Debug.xcconfig
├── Release.xcconfig
└── Staging.xcconfig
    ├── YGB-Application.xcconfig
    │   ├── YGB-Debug.xcconfig
    │   ├── YGB-Release.xcconfig
    │   └── YGB-Staging.xcconfig
    └── DEMO-Application.xcconfig
        ├── DEMO-Debug.xcconfig
        ├── DEMO-Release.xcconfig
        └── DEMO-Staging.xcconfig
```

### 3. Build Schemes

Create the following schemes in Xcode:

- **YGB-Debug** → YGB target + YGB-Debug config
- **YGB-Release** → YGB target + YGB-Release config
- **YGB-Staging** → YGB target + YGB-Staging config
- **DEMO-Debug** → DEMO target + DEMO-Debug config
- **DEMO-Release** → DEMO target + DEMO-Release config
- **DEMO-Staging** → DEMO target + DEMO-Staging config

### 4. SwiftGen Setup

Run SwiftGen to generate localization keys:

```bash
swiftgen run
```

This generates:
- `Generated/L10n.swift` - Localization keys
- `Generated/Assets.swift` - Asset catalogs

Add a build phase to run SwiftGen automatically:

1. **Build Phases** → **New Run Script Phase**
2. Add: `swiftgen run`

### 5. SwiftLint Setup

Add SwiftLint build phase:

1. **Build Phases** → **New Run Script Phase**
2. Add: `"${PODS_ROOT}/SwiftLint/swiftlint"` (or just `swiftlint`)

## Project Structure

```
IOSStartApp/
├── App/
│   ├── AppDelegate.swift          # Main app entry point
│   └── RootView.swift             # Root SwiftUI view
├── Core/
│   ├── Plugin/                    # Plugin system
│   │   ├── ApplicationService.swift
│   │   └── PluggableApplicationDelegate.swift
│   ├── Routing/                   # Navigation system
│   │   ├── Route.swift
│   │   ├── Navigator.swift
│   │   └── Navigations/
│   │       ├── LaunchAppNavigation.swift
│   │       ├── HomeNavigation.swift
│   │       ├── AppGuideNavigation.swift
│   │       └── CustomAlertNavigation.swift
│   ├── Theme/
│   │   └── AppTheme.swift         # Design tokens
│   ├── Localization/
│   │   └── LocalizationManager.swift
│   ├── Networking/
│   │   ├── APIClient.swift
│   │   └── NetworkError.swift
│   ├── UIComponents/
│   │   ├── AppButton.swift
│   │   ├── AppTextField.swift
│   │   └── StateViews.swift
│   └── Alert/
│       └── AlertCenter.swift
├── Plugins/
│   ├── FirebasePlugin.swift
│   ├── NotificationPlugin.swift
│   ├── WindowPlugin.swift
│   ├── KeyboardPlugin.swift
│   ├── LocalizationPlugin.swift
│   ├── ThemePlugin.swift
│   ├── SecurityPlugin.swift
│   └── RouterPlugin.swift
├── Features/
│   └── AppGuide/
│       └── AppGuideView.swift
├── Resources/
│   ├── Localization/
│   │   ├── en.lproj/
│   │   │   └── Localizable.strings
│   │   └── ar.lproj/
│   │       └── Localizable.strings
│   └── Info.plist
├── Targets/
│   ├── Shared/Configurations/
│   │   ├── Base.xcconfig
│   │   ├── Debug.xcconfig
│   │   ├── Release.xcconfig
│   │   └── Staging.xcconfig
│   ├── YGB/
│   │   ├── Configurations/
│   │   │   ├── YGB-Application.xcconfig
│   │   │   ├── YGB-Debug.xcconfig
│   │   │   ├── YGB-Release.xcconfig
│   │   │   └── YGB-Staging.xcconfig
│   │   └── GoogleService-Info.plist
│   └── DEMO/
│       ├── Configurations/
│       │   ├── DEMO-Application.xcconfig
│       │   ├── DEMO-Debug.xcconfig
│       │   ├── DEMO-Release.xcconfig
│       │   └── DEMO-Staging.xcconfig
│       └── GoogleService-Info.plist
├── Podfile
├── .swiftlint.yml
├── swiftgen.yml
└── SETUP_GUIDE.md
```

## Configuration Variables

### Base Configuration (Targets/Shared/Configurations/Base.xcconfig)

- `APP_NAME` - Application name
- `CLIENT_NAME` - Client name
- `IPHONEOS_DEPLOYMENT_TARGET` - Minimum iOS version
- `SWIFT_VERSION` - Swift version

### Flavor Configuration

Each flavor (YGB, DEMO) has:

- `FLAVOR` - Flavor identifier
- `APP_DISPLAY_NAME` - App name in home screen
- `APP_IDENTIFIER` - Bundle identifier
- `TEAM_ID` - Development team ID
- `BANK_CODE` - Bank/Client code
- `CONFIG_KEY` - Configuration key
- `API_BASE_URL` - API endpoint
- `FIREBASE_PROJECT_ID` - Firebase project

### Environment-Specific (Debug/Staging/Release)

- `API_ENVIRONMENT` - Environment (development, staging, production)
- `LOG_LEVEL` - Logging level
- `ENABLE_NETWORK_LOGGING` - Network request logging
- `SECURITY_CERTIFICATE_PINNING_ENABLED` - SSL pinning

## Adding a New Flavor

### Step 1: Create Configuration Files

```bash
mkdir -p Targets/NEWFLAVOR/Configurations
```

Create these files:
- `NEWFLAVOR-Application.xcconfig`
- `NEWFLAVOR-Debug.xcconfig`
- `NEWFLAVOR-Release.xcconfig`
- `NEWFLAVOR-Staging.xcconfig`

**Example (NEWFLAVOR-Application.xcconfig):**

```xcconfig
#include "../../../Targets/Shared/Configurations/Base.xcconfig"

FLAVOR = NEWFLAVOR
APP_DISPLAY_NAME = NewFlavor App
APP_IDENTIFIER_PREFIX = com.example.newflavor
APP_IDENTIFIER = $(APP_IDENTIFIER_PREFIX).app
BUNDLE_ID = $(APP_IDENTIFIER)
BANK_CODE = NEWFLAVOR
CONFIG_KEY = newflavor_config_v1
API_BASE_URL = https://api-newflavor.example.com
```

### Step 2: Create GoogleService-Info.plist

```bash
mkdir -p Targets/NEWFLAVOR
cp Targets/YGB/GoogleService-Info.plist Targets/NEWFLAVOR/GoogleService-Info.plist
# Edit with your Firebase credentials
```

### Step 3: Create Xcode Target

1. Select **IOSStartApp** project
2. **Targets** → **+ (Add)**
3. Select **App** template
4. Name: `NEWFLAVOR`
5. Assign config files in Build Settings

### Step 4: Create Schemes

Create schemes for each configuration:
- `NEWFLAVOR-Debug`
- `NEWFLAVOR-Release`
- `NEWFLAVOR-Staging`

## Adding a New Feature Module

### Step 1: Create Feature Directory

```bash
mkdir -p Features/MyFeature
```

### Step 2: Create Feature Files

```swift
// Features/MyFeature/MyFeatureView.swift
import SwiftUI

struct MyFeatureView: View {
    @ObservedObject var navigator: Navigator
    @Environment(\.appTheme) var theme

    var body: some View {
        VStack {
            Text("My Feature")
                .font(theme.typography.headlineLarge)
        }
    }
}
```

### Step 3: Create Navigation

```swift
// Core/Routing/Navigations/MyFeatureNavigation.swift
class MyFeatureNavigation: AppNavigation {
    func registerRoutes(_ navigator: Navigator) {
        navigator.registerRoute("my-feature") { navigator in
            AnyView(MyFeatureView(navigator: navigator))
        }
    }
}
```

### Step 4: Register in AppDelegate

```swift
// App/AppDelegate.swift
override func services() -> [ApplicationService] {
    [
        // ... existing plugins ...
        RouterPlugin(navigations: [
            LaunchAppNavigation(),
            HomeNavigation(),
            MyFeatureNavigation(),  // Add here
            CustomAlertNavigation(),
            AppGuideNavigation()
        ])
    ]
}
```

## Adding Localization Keys

### Step 1: Add to Localizable.strings

**English (Resources/Localization/en.lproj/Localizable.strings):**
```
"my_key" = "My English Text";
```

**Arabic (Resources/Localization/ar.lproj/Localizable.strings):**
```
"my_key" = "نصي العربي";
```

### Step 2: Regenerate SwiftGen

```bash
swiftgen run
```

This generates:
```swift
// Generated/L10n.swift
enum L10n {
    static let myKey = NSLocalizedString("my_key", comment: "")
}
```

### Step 3: Use in Code

```swift
Text(L10n.myKey)  // SwiftGen generated
// OR
Text("my_key".localized())  // String extension
```

### Step 4: Runtime Language Switching

```swift
// Switch language at runtime
LocalizationManager.shared.setLanguage(.arabic)
LocalizationManager.shared.setLanguage(.english)
```

## Architecture Overview

### MVVM + Coordinator Pattern

```
View (SwiftUI)
  ↓
ViewModel (Observable)
  ↓
Model (Data)
  ↓
Coordinator/Router (Navigation Logic)
```

### Plugin System

Plugins are loaded in `AppDelegate` and initialized in order:

```
FirebasePlugin
  ↓
NotificationPlugin
  ↓
WindowPlugin (Creates UI)
  ↓
LocalizationPlugin (RTL support)
  ↓
ThemePlugin (Design tokens)
  ↓
SecurityPlugin
  ↓
KeyboardPlugin
  ↓
RouterPlugin (Navigation)
```

## Key Features

### Theme System

```swift
// Use design tokens
@Environment(\.appTheme) var theme

VStack(spacing: theme.spacing.md) {
    Text("Title")
        .font(theme.typography.titleLarge)
        .foregroundColor(theme.colors.primary)
}
```

### Networking

```swift
// Async/await + Alamofire
let result: MyModel = try await APIClient.shared.request("endpoint")

// Error handling
do {
    let data = try await APIClient.shared.request("endpoint")
} catch let error as NetworkError {
    print(error.localizedDescription)
}
```

### Localization

```swift
// Runtime switching
LocalizationManager.shared.setLanguage(.arabic)

// String extension
Text("app_name".localized())

// RTL support (automatic)
@Published var isRTL: Bool
```

### Alerts

```swift
// Simple alert
AlertCenter.shared.showSuccess(message: "Success!")

// Confirmation dialog
AlertCenter.shared.confirm(message: "Delete?") {
    // Handle confirmation
}

// Custom alert screen
navigator.presentSheet(AppRoute(path: .customAlert))
```

## Building and Running

### Debug Build

```bash
xcodebuild -workspace IOSStartApp.xcworkspace \
  -scheme YGB-Debug \
  -configuration Debug \
  -destination 'platform=iOS Simulator,name=iPhone 15'
```

### Release Build

```bash
xcodebuild -workspace IOSStartApp.xcworkspace \
  -scheme YGB-Release \
  -configuration Release \
  -destination 'platform=iOS Simulator,name=iPhone 15'
```

## Dependencies

- **Alamofire** - HTTP networking
- **PromiseKit** - Promise-based async
- **Firebase/Core** - Analytics
- **Firebase/Messaging** - Push notifications
- **IQKeyboardManagerSwift** - Keyboard management
- **SwiftLint** - Code linting
- **SwiftGen** - Code generation

## Troubleshooting

### Build Errors

**"Cannot find module"**
- Run `pod install` again
- Delete derived data: `rm -rf ~/Library/Developer/Xcode/DerivedData/*`

**"Config file not found"**
- Check XCConfig path in Build Settings
- Ensure all includes are relative paths

**"App crashes on launch"**
- Check AppDelegate plugins initialization
- Verify GoogleService-Info.plist is included

### Runtime Issues

**Localization not updating**
- Call `LocalizationManager.shared.setLanguage()` to update
- Ensure Localizable.strings are added to target

**Theme not applying**
- Check `.appTheme()` modifier on views
- Verify theme environment key is set in RootView

## Best Practices

1. **Always use xcconfig for configuration**
2. **Keep business logic in ViewModels**
3. **Use design tokens for styling**
4. **Add localization for all user-facing text**
5. **Test across all flavors and configurations**
6. **Follow SwiftLint rules**
7. **Use async/await for networking**
8. **Implement proper error handling**

## Support

For issues or questions:
1. Check the App Guide screen in-app
2. Review component examples
3. Verify configuration files
4. Check build logs for warnings

## License

This template is provided as a standard for enterprise iOS development.
