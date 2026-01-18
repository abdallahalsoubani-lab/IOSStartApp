# 🎓 دليل التدريب الكامل

## 📖 مقدمة

هذا الدليل موجه للمتدربين الجدد على التطبيق. يحتوي على شرح كامل لكل شيء في التطبيق مع أمثلة عملية.

---

## 🚀 صفحة التدريب

تم إنشاء **صفحة تدريبية كاملة** تحتوي على:

✅ جميع أنواع الـ Buttons (Primary, Secondary, Outlined, Ghost, Loading, Disabled)
✅ جميع أنواع الـ TextFields (Normal, Error, Success, Loading, Secure)
✅ Form كامل مع Validation
✅ Toggle, Picker, Switch
✅ أمثلة على API Calls (GET & POST)
✅ API حقيقي جاهز: JSONPlaceholder
✅ Loading, Error, Empty States
✅ Lists & ScrollViews
✅ Navigation Examples (Alert, Sheet, Navigate)
✅ Comments مفصلة لكل عنصر

---

## 📂 الملفات المُنشأة

### 1. `Features/Training/TrainingView.swift`
الـ View الرئيسي - يحتوي على واجهة الصفحة وجميع الأمثلة

### 2. `Features/Training/TrainingViewModel.swift`
الـ ViewModel - يحتوي على:
- Models (User, Post)
- API Service (TrainingAPIService)
- Business Logic
- Form Validation

### 3. `Core/Routing/Navigations/TrainingNavigation.swift`
تسجيل الصفحة في نظام الـ Navigation

---

## 🎯 كيف تصل للصفحة التدريبية؟

### من التطبيق:
1. افتح التطبيق
2. في الـ Home Screen
3. اضغط على زر "🎓 صفحة التدريب (كل شي هنا!)"

### من الكود:
```swift
navigator.navigate(to: AppRoute(path: .training))
```

---

## 📚 شرح الأقسام

### القسم 1: الأزرار (Buttons)

#### ما الموجود؟
- **Primary Button**: الزر الأساسي (للإجراءات المهمة)
- **Secondary Button**: زر ثانوي
- **Outlined Button**: زر بإطار (Stroke)
- **Ghost Button**: زر شفاف
- **Loading Button**: زر مع حالة تحميل
- **Disabled Button**: زر معطل
- **Button with Icon**: زر مع أيقونة

#### كيف تستخدمه؟
```swift
// Primary Button
AppButton(
    title: "احفظ",           // النص
    style: .primary,         // النوع
    isLoading: false,        // هل يحمّل؟
    isDisabled: false        // هل معطل؟
) {
    // الإجراء عند الضغط
    print("تم الضغط!")
}
```

#### الأنواع المتاحة:
- `.primary` - أزرق (للإجراءات المهمة)
- `.secondary` - ثانوي
- `.outlined` - بإطار
- `.ghost` - شفاف

---

### القسم 2: حقول النص (TextFields)

#### ما الموجود؟
- **Normal TextField**: حقل عادي
- **Error TextField**: حقل مع رسالة خطأ
- **Success TextField**: حقل مع رسالة نجاح
- **Loading TextField**: حقل مع حالة تحميل
- **Secure Field**: لكلمات المرور
- **TextEditor**: نص متعدد الأسطر

#### كيف تستخدمه؟
```swift
// تعريف متغير للقيمة
@State private var email: String = ""

// استخدام الـ TextField
AppTextField(
    text: $email,                    // الـ Binding
    placeholder: "البريد الإلكتروني", // النص التوضيحي
    state: .normal                    // الحالة
)
```

#### الحالات المتاحة:
- `.normal` - عادي
- `.error("رسالة الخطأ")` - خطأ
- `.success("رسالة النجاح")` - نجاح
- `.loading` - تحميل

---

### القسم 3: Form مع Validation

#### ما هو الـ Validation؟
هو التحقق من صحة البيانات المدخلة قبل إرسالها.

#### مثال عملي:
```swift
func saveForm() {
    // 1. تنظيف الحالات السابقة
    nameFieldState = .normal
    emailFieldState = .normal
    
    // 2. التحقق من الاسم
    if nameField.isEmpty {
        nameFieldState = .error("الرجاء إدخال الاسم")
        return
    }
    
    if nameField.count < 3 {
        nameFieldState = .error("الاسم يجب أن يكون 3 أحرف على الأقل")
        return
    }
    
    // 3. التحقق من الإيميل
    if !isValidEmail(emailField) {
        emailFieldState = .error("البريد الإلكتروني غير صحيح")
        return
    }
    
    // 4. كل شي تمام، نرسل للـ API
    Task {
        let user = try await apiService.createUser(
            name: nameField,
            email: emailField
        )
        print("نجح! المستخدم: \(user.name)")
    }
}
```

#### نصائح:
- دائماً نظف الحالات السابقة قبل البدء
- افحص كل حقل على حدة
- أعرض رسائل خطأ واضحة
- لا ترسل للـ API إلا إذا كل شي صح

---

### القسم 4: Toggle & Picker

#### Toggle (مفتاح التبديل)
للتفعيل/التعطيل

```swift
@State private var isEnabled: Bool = false

Toggle(isOn: $isEnabled) {
    Text("تفعيل الإشعارات")
}
.tint(theme.colors.primary) // لون المفتاح
```

#### Picker (القائمة المنسدلة)
للاختيار من قائمة

```swift
@State private var selectedCountry: String = "السعودية"
let countries = ["السعودية", "الإمارات", "الكويت"]

Picker("الدولة", selection: $selectedCountry) {
    ForEach(countries, id: \.self) { country in
        Text(country).tag(country)
    }
}
.pickerStyle(.menu) // نوع الـ Picker
```

#### أنواع الـ Picker:
- `.menu` - قائمة منسدلة
- `.segmented` - أزرار متجاورة
- `.wheel` - عجلة دوارة

---

## 🌐 القسم 5: API Calls

### ما هو الـ API؟
API = Application Programming Interface
هو وسيلة للتواصل بين التطبيق والسيرفر (Server).

### الـ API المستخدم:
```
https://jsonplaceholder.typicode.com
```
هذا API مجاني ومفتوح للتجربة، لا يحتاج تسجيل.

---

### كيف نستدعي API؟

#### خطوة 1: إنشاء الموديل (Model)
```swift
// الموديل يمثل الـ JSON اللي راح نستقبله
struct User: Codable, Identifiable {
    let id: Int
    let name: String
    let email: String
}
```

#### خطوة 2: إنشاء الـ Request
```swift
// GET Request - جلب البيانات
func fetchUsers() async throws -> [User] {
    // 1. بناء الـ URL
    let url = URL(string: "https://jsonplaceholder.typicode.com/users")!
    
    // 2. إنشاء الـ Request
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    
    // 3. إرسال الـ Request
    let (data, response) = try await URLSession.shared.data(for: request)
    
    // 4. فك تشفير الـ JSON
    let users = try JSONDecoder().decode([User].self, from: data)
    
    return users
}
```

#### خطوة 3: الاستخدام في الـ ViewModel
```swift
@MainActor
class MyViewModel: ObservableObject {
    @Published var users: [User] = []
    @Published var isLoading: Bool = false
    
    func loadUsers() {
        Task {
            isLoading = true
            
            do {
                users = try await fetchUsers()
                print("✅ تم جلب \(users.count) مستخدم")
            } catch {
                print("❌ خطأ: \(error)")
            }
            
            isLoading = false
        }
    }
}
```

#### خطوة 4: الاستخدام في الـ View
```swift
struct MyView: View {
    @StateObject var viewModel = MyViewModel()
    
    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView("جاري التحميل...")
            } else {
                List(viewModel.users) { user in
                    Text(user.name)
                }
            }
        }
        .onAppear {
            viewModel.loadUsers()
        }
    }
}
```

---

### POST Request - إرسال بيانات

```swift
func createUser(name: String, email: String) async throws -> User {
    let url = URL(string: "https://jsonplaceholder.typicode.com/users")!
    
    // إنشاء الـ Body
    let body: [String: Any] = [
        "name": name,
        "email": email
    ]
    let jsonData = try JSONSerialization.data(withJSONObject: body)
    
    // إنشاء الـ Request
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.httpBody = jsonData
    
    // إرسال
    let (data, _) = try await URLSession.shared.data(for: request)
    
    // فك التشفير
    let user = try JSONDecoder().decode(User.self, from: data)
    
    return user
}
```

---

### أنواع الـ Requests:

| النوع | الاستخدام | مثال |
|-------|-----------|------|
| **GET** | جلب البيانات | قائمة المستخدمين |
| **POST** | إنشاء بيانات جديدة | تسجيل مستخدم جديد |
| **PUT** | تحديث كامل | تعديل بيانات المستخدم |
| **PATCH** | تحديث جزئي | تعديل الاسم فقط |
| **DELETE** | حذف | حذف مستخدم |

---

## 🎨 القسم 6: State Views

### ما هي الـ State Views؟
شاشات توضح حالة التطبيق:

#### 1. Loading View (جاري التحميل)
```swift
LoadingView(message: "جاري التحميل...")
```

#### 2. Empty State View (لا توجد بيانات)
```swift
EmptyStateView(
    title: "لا توجد بيانات",
    message: "لم يتم العثور على أي عناصر"
)
```

#### 3. Error State View (حدث خطأ)
```swift
ErrorStateView(
    message: "حدث خطأ أثناء التحميل"
) {
    // إعادة المحاولة
    viewModel.retry()
}
```

---

## 📝 القسم 7: Lists (القوائم)

### كيف تنشئ قائمة؟

```swift
// البيانات
let users: [User] = [...]

// القائمة
List(users) { user in
    HStack {
        Text(user.name)
        Spacer()
        Text(user.email)
    }
}
```

### أو باستخدام ScrollView + ForEach:

```swift
ScrollView {
    VStack(spacing: 10) {
        ForEach(users) { user in
            UserRowView(user: user)
        }
    }
}
```

---

## 🧭 القسم 8: Navigation (التنقل)

### أنواع التنقل:

#### 1. Navigate (Push) - الدخول لصفحة جديدة
```swift
navigator.navigate(to: AppRoute(path: .training))
```

#### 2. Present Sheet - عرض Modal من الأسفل
```swift
navigator.presentSheet(AppRoute(path: .customAlert))
```

#### 3. Pop - الرجوع للصفحة السابقة
```swift
navigator.pop()
```

#### 4. Pop to Root - الرجوع للصفحة الرئيسية
```swift
navigator.popToRoot()
```

#### 5. Show Alert - عرض تنبيه
```swift
@State private var showAlert = false

// في الـ View
.alert("عنوان", isPresented: $showAlert) {
    Button("حسناً", role: .cancel) { }
} message: {
    Text("الرسالة")
}

// للعرض
showAlert = true
```

---

## 🎨 استخدام الـ Theme

### الألوان:
```swift
@Environment(\.appTheme) var theme

// الألوان المتاحة:
theme.colors.primary          // اللون الأساسي
theme.colors.secondary        // اللون الثانوي
theme.colors.accent           // لون التمييز
theme.colors.error            // لون الخطأ
theme.colors.success          // لون النجاح
theme.colors.warning          // لون التحذير
theme.colors.info             // لون المعلومات
theme.colors.background       // لون الخلفية
theme.colors.surface          // لون السطح
theme.colors.onPrimary        // نص على اللون الأساسي
theme.colors.onBackground     // نص على الخلفية
```

### الخطوط:
```swift
// أحجام الخطوط المتاحة:
theme.typography.displayLarge     // عنوان كبير جداً
theme.typography.displayMedium
theme.typography.displaySmall
theme.typography.headlineLarge    // عنوان كبير
theme.typography.headlineMedium
theme.typography.headlineSmall
theme.typography.titleLarge       // عنوان
theme.typography.titleMedium
theme.typography.titleSmall
theme.typography.bodyLarge        // نص عادي
theme.typography.bodyMedium
theme.typography.bodySmall
theme.typography.labelLarge       // تسمية
theme.typography.labelMedium
theme.typography.labelSmall
```

### المسافات:
```swift
// المسافات المتاحة:
theme.spacing.xs    // 4
theme.spacing.sm    // 8
theme.spacing.md    // 16
theme.spacing.lg    // 24
theme.spacing.xl    // 32
theme.spacing.xxl   // 40
```

### الظلال:
```swift
// الظلال المتاحة:
theme.shadows.small   // ظل صغير
theme.shadows.medium  // ظل متوسط
theme.shadows.large   // ظل كبير

// الاستخدام:
.shadow(
    color: theme.shadows.small.color,
    radius: theme.shadows.small.radius,
    x: theme.shadows.small.x,
    y: theme.shadows.small.y
)
```

---

## 🌍 Localization (الترجمة)

### تغيير اللغة:
```swift
// للإنجليزية
LocalizationManager.shared.setLanguage(.english)

// للعربية
LocalizationManager.shared.setLanguage(.arabic)
```

### استخدام النصوص المترجمة:
```swift
// في الكود
Text("app_name".localized())

// إضافة نص جديد:
// 1. افتح Resources/Localization/en.lproj/Localizable.strings
"my_text" = "My Text";

// 2. افتح Resources/Localization/ar.lproj/Localizable.strings
"my_text" = "النص الخاص بي";

// 3. استخدمه
Text("my_text".localized())
```

---

## 🔧 كيف تعدل على الأسماء؟

### تعديل اسم الـ App:
1. افتح `Targets/YGB/Configurations/YGB-Application.xcconfig`
2. غيّر:
```
APP_DISPLAY_NAME = YGB App  // ← غيّر هنا
```

### تعديل Bundle ID:
```
APP_IDENTIFIER = com.example.ygb.app  // ← غيّر هنا
```

### تعديل Team ID:
```
TEAM_ID = YOUR_TEAM_ID  // ← غيّر هنا
```

---

## ✅ Checklist للمتدربين

بعد دراسة الصفحة التدريبية، تأكد من فهمك:

### الأساسيات:
- [ ] كيفية استخدام الـ Buttons
- [ ] كيفية استخدام الـ TextFields
- [ ] كيفية عمل Form مع Validation
- [ ] استخدام Toggle & Picker

### المتقدم:
- [ ] فهم الـ API Calls (GET & POST)
- [ ] فهم الـ async/await
- [ ] استخدام الـ ViewModel
- [ ] استخدام @Published & @State

### الـ UI:
- [ ] استخدام الـ Theme (Colors, Typography, Spacing)
- [ ] استخدام الـ State Views
- [ ] إنشاء Lists
- [ ] التنقل بين الصفحات

---

## 🎯 تمارين عملية

### تمرين 1: Button بسيط
أنشئ زر يعرض Alert عند الضغط عليه.

### تمرين 2: Form مع Validation
أنشئ Form فيه Name & Email مع Validation.

### تمرين 3: API Call
استخدم JSONPlaceholder لجلب قائمة Posts وعرضها في List.

### تمرين 4: صفحة كاملة
أنشئ صفحة Profile فيها:
- صورة دائرية
- Name TextField
- Email TextField
- Bio TextEditor
- Save Button

---

## 📚 مصادر إضافية

### APIs مجانية للتجربة:
1. **JSONPlaceholder**: https://jsonplaceholder.typicode.com
   - Users, Posts, Comments, Photos
   
2. **ReqRes**: https://reqres.in
   - Users API مع صور

3. **DummyAPI**: https://dummyapi.io
   - Users, Posts, Comments

### مواقع مفيدة:
- Apple Documentation: https://developer.apple.com/documentation/swiftui
- Hacking with Swift: https://www.hackingwithswift.com

---

## 💡 نصائح مهمة

### 1. استخدم Comments
```swift
// ✅ جيد
// جلب المستخدمين من API
func fetchUsers() { }

// ❌ سيء
func f() { }
```

### 2. استخدم أسماء واضحة
```swift
// ✅ جيد
let userEmailAddress = "test@example.com"

// ❌ سيء
let e = "test@example.com"
```

### 3. افصل الـ Logic عن الـ UI
- الـ View للعرض فقط
- الـ ViewModel للـ Logic
- الـ Model للبيانات

### 4. استخدم async/await للـ API
```swift
// ✅ حديث وأفضل
func fetchData() async throws -> [User] { }

// ❌ قديم
func fetchData(completion: @escaping ([User]) -> Void) { }
```

### 5. تعامل مع الأخطاء
```swift
do {
    let users = try await fetchUsers()
    print("✅ نجح")
} catch {
    print("❌ خطأ: \(error)")
}
```

---

## 🎉 خلاصة

الآن عندك:
✅ صفحة تدريبية كاملة فيها كل شي
✅ أمثلة عملية على كل component
✅ API حقيقي يشتغل
✅ Comments واضحة لكل سطر
✅ دليل توثيق شامل

**ابدأ الآن! افتح التطبيق → Home → صفحة التدريب 🎓**

---

**بالتوفيق! 🚀**
