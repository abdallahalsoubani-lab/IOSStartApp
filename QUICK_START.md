# Quick Start - Enterprise iOS Template

## 🚀 Setup in 3 Steps

### Step 1: Install Dependencies
```bash
cd IOSStartApp
pod install
```

### Step 2: Open Project
```bash
open IOSStartApp.xcworkspace
```

**IMPORTANT**: Always open `.xcworkspace`, not `.xcodeproj`

### Step 3: Select Flavor & Build
1. In Xcode, select a scheme:
   - **YGB-Debug** (for YGB flavor, Debug configuration)
   - **DEMO-Debug** (for DEMO flavor, Debug configuration)

2. Select a simulator (iPhone 15, iPhone 15 Pro, etc.)
3. Click **Run** (⌘R)

---

## 📋 Available Schemes

### YGB Flavor
- `YGB-Debug` - Development build
- `YGB-Release` - Production build
- `YGB-Staging` - Staging/QA build

### DEMO Flavor
- `DEMO-Debug` - Development build
- `DEMO-Release` - Production build
- `DEMO-Staging` - Staging/QA build

---

## 🎯 What to Do Next

1. **Update Configurations**
   - Edit `Targets/YGB/Configurations/YGB-Application.xcconfig`
   - Or `Targets/DEMO/Configurations/DEMO-Application.xcconfig`
   - Change bundle identifiers, team IDs, API URLs, etc.

2. **Configure Firebase**
   - Update `Targets/YGB/GoogleService-Info.plist`
   - Update `Targets/DEMO/GoogleService-Info.plist`
   - Get these from your Firebase Console

3. **Explore the Template**
   - Open the app and tap **"Open App Guide / Components Catalog"**
   - See all components and design system in action
   - Check the AppGuideView source code for examples

4. **Read Documentation**
   - `README.md` - Feature overview
   - `SETUP_GUIDE.md` - Complete setup guide
   - `PROJECT_MANIFEST.md` - File structure reference

---

## 🔧 Build Settings & Configurations

All build settings are managed via **xcconfig files**:

```
Targets/
├── Shared/Configurations/      # Shared for all flavors/configs
│   ├── Base.xcconfig          # iOS 17, Swift 5.10
│   ├── Debug.xcconfig         # Debug settings
│   ├── Release.xcconfig       # Production settings
│   └── Staging.xcconfig       # Staging settings
├── YGB/Configurations/         # YGB flavor specific
│   ├── YGB-Application.xcconfig
│   ├── YGB-Debug.xcconfig
│   ├── YGB-Release.xcconfig
│   └── YGB-Staging.xcconfig
└── DEMO/Configurations/        # DEMO flavor specific
    ├── DEMO-Application.xcconfig
    ├── DEMO-Debug.xcconfig
    ├── DEMO-Release.xcconfig
    └── DEMO-Staging.xcconfig
```

### Key Configuration Variables

| Variable | Purpose | Example |
|----------|---------|---------|
| `APP_DISPLAY_NAME` | App name on home screen | "YGB App" |
| `APP_IDENTIFIER` | Bundle identifier | com.example.ygb.app |
| `BANK_CODE` | Client/bank code | YGB |
| `API_BASE_URL` | API endpoint | https://api-ygb.example.com |
| `TEAM_ID` | Development team ID | ABC123XYZ |

---

## 🛠️ Troubleshooting

### Issue: "Cannot find module FirebaseCore"
**Solution**: Run `pod install` again and close Xcode completely before reopening

### Issue: "Build failed - Could not find Info.plist"
**Solution**: Check that `Resources/Info.plist` is added to the target in Build Phases

### Issue: "Missing GoogleService-Info.plist"
**Solution**: Download from Firebase Console and place in `Targets/YGB/` or `Targets/DEMO/`

### Issue: "Code signing error"
**Solution**:
1. In Xcode, select project → Target
2. Go to Signing & Capabilities
3. Select your development team

### Issue: "Pods not found"
**Solution**:
```bash
rm -rf Pods Podfile.lock
pod install
open IOSStartApp.xcworkspace
```

---

## 📚 Project Structure

### Core Modules
- **App/** - AppDelegate, RootView, environment
- **Core/Routing/** - Navigation system (Router, Routes, Navigations)
- **Core/Theme/** - Design tokens and theming
- **Core/Networking/** - APIClient with async/await
- **Core/Localization/** - i18n with Arabic/English support
- **Core/UIComponents/** - Reusable SwiftUI components
- **Core/Alert/** - Alert system
- **Core/Plugin/** - Plugin architecture

### Features
- **Features/AppGuide/** - In-app component catalog

### Plugins
- **Plugins/** - 8 plugins for modular initialization
  - Firebase, Notifications, Window, Keyboard, etc.

### Resources
- **Resources/Localization/** - English & Arabic strings
- **Resources/Info.plist** - App configuration

---

## 🎨 Using the Design System

All UI components use design tokens from `AppTheme`:

```swift
import SwiftUI

struct MyView: View {
    @Environment(\.appTheme) var theme

    var body: some View {
        VStack(spacing: theme.spacing.md) {
            Text("Title")
                .font(theme.typography.headlineLarge)
                .foregroundColor(theme.colors.primary)

            AppButton("Action") {
                print("Tapped")
            }
        }
    }
}
```

---

## 🌍 Localization

### Current Languages
- **English** (en)
- **Arabic** (ar) with RTL support

### Change Language at Runtime
```swift
LocalizationManager.shared.setLanguage(.arabic)
LocalizationManager.shared.setLanguage(.english)
```

### Add New String Keys
1. Edit `Resources/Localization/en.lproj/Localizable.strings`
2. Edit `Resources/Localization/ar.lproj/Localizable.strings`
3. Run: `swiftgen run`
4. Use in code: `Text("my_key".localized())`

---

## 🚀 Building for Release

### Create Release Build
1. Select **YGB-Release** or **DEMO-Release** scheme
2. Select **Generic iOS Device** or archive destination
3. Build → Archive
4. Submit to App Store

### Archive Command Line
```bash
xcodebuild archive \
  -workspace IOSStartApp.xcworkspace \
  -scheme YGB-Release \
  -configuration Release \
  -archivePath "build/IOSStartApp.xcarchive"
```

---

## 📞 Support

- **Quick Questions**: See QUICK_START.md (this file)
- **Detailed Setup**: Read SETUP_GUIDE.md
- **File Reference**: Check PROJECT_MANIFEST.md
- **Component Examples**: Open AppGuideView in the app

---

## ✅ You're Ready!

Your enterprise iOS app template is ready to use. Start by:
1. `pod install`
2. `open IOSStartApp.xcworkspace`
3. Select YGB-Debug scheme
4. Press Run (⌘R)

Happy coding! 🎉
