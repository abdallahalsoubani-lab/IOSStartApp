# كيف تضيف صفحة جديدة في 3 خطوات بسيطة 🚀

## الخطوة 1️⃣: أضف Route للصفحة

افتح ملف `Core/Routing/Route.swift` وأضف route جديد:

```swift
struct AppRoute: Route {
    enum Path: String {
        case launch = "launch"
        case login = "login"
        case home = "home"
        case customAlert = "custom-alert"
        case appGuide = "app-guide"
        case settings = "settings"  // ← أضف الصفحة الجديدة هنا
    }
}
```

---

## الخطوة 2️⃣: أنشئ ملف Navigation للصفحة

أنشئ ملف جديد في `Core/Routing/Navigations/SettingsNavigation.swift`:

```swift
import SwiftUI

class SettingsNavigation: AppNavigation {
    func registerRoutes(_ navigator: Navigator) {
        navigator.registerRoute("settings") { navigator in
            AnyView(SettingsView(navigator: navigator))
        }
    }
}

struct SettingsView: View {
    @ObservedObject var navigator: Navigator
    @Environment(\.appTheme) var theme
    
    var body: some View {
        VStack(spacing: theme.spacing.lg) {
            Text("Settings Screen")
                .font(theme.typography.headlineLarge)
                .foregroundColor(theme.colors.onBackground)
            
            // محتوى الصفحة هنا
            
            Button(action: {
                navigator.pop() // للرجوع
            }) {
                Text("Back")
                    .frame(maxWidth: .infinity)
                    .padding(theme.spacing.md)
                    .background(theme.colors.primary)
                    .foregroundColor(theme.colors.onPrimary)
                    .cornerRadius(8)
            }
            
            Spacer()
        }
        .padding(theme.spacing.lg)
    }
}

#Preview {
    SettingsView(navigator: Navigator())
        .appTheme(AppTheme())
}
```

---

## الخطوة 3️⃣: سجّل الـ Navigation في RouterPlugin

افتح `Plugins/RouterPlugin.swift` وأضف السطر التالي:

```swift
class RouterPlugin: NSObject, ApplicationService {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let navigations: [AppNavigation] = [
            LaunchAppNavigation(),
            AuthenticationAppNavigation(),
            HomeNavigation(),
            CustomAlertNavigation(),
            AppGuideNavigation(),
            SettingsNavigation()  // ← أضف هنا
        ]
        
        for navigation in navigations {
            navigation.registerRoutes(Navigator.shared)
        }
        
        return true
    }
}
```

---

## ✅ خلاص! استخدم الصفحة

من أي مكان في التطبيق:

```swift
// للانتقال للصفحة (Push)
navigator.navigate(to: AppRoute(path: .settings))

// لعرضها كـ Sheet/Modal
navigator.presentSheet(AppRoute(path: .settings))

// لعرضها كـ Full Screen
navigator.present(AppRoute(path: .settings))
```

---

## 🎨 نصائح إضافية

### استخدم الـ Theme System
```swift
@Environment(\.appTheme) var theme

VStack(spacing: theme.spacing.md) {
    Text("Title")
        .font(theme.typography.headlineLarge)
        .foregroundColor(theme.colors.primary)
}
```

### استخدم الـ Localization
```swift
Text("welcome_message".localized())
```

### استخدم الـ Components الجاهزة
```swift
// Button
AppButton(
    title: "Save",
    style: .primary,
    action: { /* action */ }
)

// TextField
AppTextField(
    text: $email,
    placeholder: "Email",
    state: .normal
)

// Loading View
LoadingView(message: "Loading...")

// Empty State
EmptyStateView(
    title: "No Data",
    message: "Try again later"
)
```

---

## 📁 البنية المقترحة للصفحات الكبيرة

إذا كانت الصفحة كبيرة، افصلها إلى مجلد:

```
Features/
├── Settings/
│   ├── SettingsView.swift           # الـ View
│   ├── SettingsViewModel.swift      # الـ ViewModel (إذا لزم)
│   └── Components/
│       ├── SettingsRowView.swift    # Component
│       └── SettingsHeaderView.swift # Component
```

ثم في `Core/Routing/Navigations/SettingsNavigation.swift` فقط سجّل الـ Route.

---

## 🔄 أمثلة على Navigation

```swift
// 1. Push Navigation (مع Back Button)
navigator.navigate(to: AppRoute(path: .settings))

// 2. Sheet/Modal (من الأسفل)
navigator.presentSheet(AppRoute(path: .customAlert))

// 3. Pop (رجوع)
navigator.pop()

// 4. Pop to Root (رجوع للرئيسية)
navigator.popToRoot()

// 5. Dismiss Sheet
navigator.dismissSheet()
```

---

## 🎯 مثال كامل: صفحة Profile

### 1. أضف Route
```swift
case profile = "profile"
```

### 2. أنشئ ملف `ProfileNavigation.swift`
```swift
import SwiftUI

class ProfileNavigation: AppNavigation {
    func registerRoutes(_ navigator: Navigator) {
        navigator.registerRoute("profile") { navigator in
            AnyView(ProfileView(navigator: navigator))
        }
    }
}

struct ProfileView: View {
    @ObservedObject var navigator: Navigator
    @Environment(\.appTheme) var theme
    @State private var name: String = ""
    @State private var email: String = ""
    
    var body: some View {
        ScrollView {
            VStack(spacing: theme.spacing.lg) {
                // Profile Image
                Circle()
                    .fill(theme.colors.primary)
                    .frame(width: 100, height: 100)
                    .overlay(
                        Image(systemName: "person.fill")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(theme.colors.onPrimary)
                            .padding(30)
                    )
                
                // Name Field
                AppTextField(
                    text: $name,
                    placeholder: "Name",
                    state: .normal
                )
                
                // Email Field
                AppTextField(
                    text: $email,
                    placeholder: "Email",
                    state: .normal
                )
                
                // Save Button
                AppButton(
                    title: "Save Changes",
                    style: .primary,
                    isLoading: false
                ) {
                    // Save logic
                }
                
                // Logout Button
                AppButton(
                    title: "Logout",
                    style: .outlined,
                    isLoading: false
                ) {
                    navigator.popToRoot()
                }
            }
            .padding(theme.spacing.lg)
        }
        .navigationTitle("Profile")
    }
}
```

### 3. سجّل في RouterPlugin
```swift
ProfileNavigation()
```

### 4. استخدمها
```swift
Button("Open Profile") {
    navigator.navigate(to: AppRoute(path: .profile))
}
```

---

## ✨ ملاحظات مهمة

1. **كل ملف Navigation يحتوي على:**
   - Class يطبّق `AppNavigation` protocol
   - Registration للـ Route
   - الـ View نفسها

2. **استخدم Preview دائماً:**
   ```swift
   #Preview {
       YourView(navigator: Navigator())
           .appTheme(AppTheme())
   }
   ```

3. **الـ Navigator متاح في كل مكان:**
   ```swift
   @ObservedObject var navigator: Navigator
   ```

4. **الـ Theme متاح عبر Environment:**
   ```swift
   @Environment(\.appTheme) var theme
   ```

---

**الآن أصبح المشروع جاهز! ركّب صفحاتك بكل سهولة 🚀**
