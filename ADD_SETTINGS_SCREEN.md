# ⚠️ كيف تفعّل صفحة Settings

الملف `SettingsNavigation.swift` جاهز لكن يحتاج يتضاف للـ Xcode project.

## الخطوات:

### 1️⃣ افتح Xcode
```bash
open IOSStartApp.xcworkspace
```

### 2️⃣ أضف الملف للمشروع

1. في Xcode، اضغط **Right Click** على مجلد `Core/Routing/Navigations/`
2. اختر **"Add Files to IOSStartApp"**
3. اختر الملف: `Core/Routing/Navigations/SettingsNavigation.swift`
4. تأكد من تحديد:
   - ✅ Copy items if needed
   - ✅ Add to targets: **YGB** و **DEMO**
5. اضغط **Add**

### 3️⃣ فعّل الـ Route

افتح `App/AppDelegate.swift` وغيّر:

```swift
// من:
// SettingsNavigation() // ⚠️ سيتم إضافتها بعد إضافة الملف

// إلى:
SettingsNavigation() // ✅ جاهز!
```

### 4️⃣ فعّل الزر في Home

افتح `Core/Routing/Navigations/HomeNavigation.swift` وغيّر:

```swift
// من:
// navigator.navigate(to: AppRoute(path: .settings))
print("Settings tapped - Add SettingsNavigation.swift to Xcode first")

// إلى:
navigator.navigate(to: AppRoute(path: .settings))
```

### 5️⃣ Build & Run

اضغط `Cmd + B` للبناء، ثم `Cmd + R` للتشغيل.

---

## ✅ الآن جاهز!

اضغط على زر "Settings" في الـ Home Screen لترى الصفحة الجديدة! 🎉

---

## 💡 للصفحات المستقبلية

عشان ما تواجه نفس المشكلة:
- كل ملف جديد تنشئه يحتاج يتضاف للـ Xcode project
- استخدم **Add Files** من داخل Xcode
- أو اسحب الملف مباشرة من Finder إلى Xcode

---

**البديل الأسهل:** افتح Xcode، واسحب الملف `SettingsNavigation.swift` من Finder إلى المجلد المناسب في Xcode! 🎯
