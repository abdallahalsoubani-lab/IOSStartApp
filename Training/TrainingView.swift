import SwiftUI

// MARK: - Training View
// ========================================
// الصفحة التدريبية الكاملة - تحتوي على جميع الأمثلة

// swiftlint:disable type_body_length
struct TrainingView: View {
    // MARK: - Properties
    
    /// الـ Navigator للتنقل بين الصفحات
    @ObservedObject var navigator: Navigator
    
    /// الـ ViewModel - يحتوي على كل البيزنس لوجك
    @StateObject private var viewModel = TrainingViewModel()
    
    /// الـ Theme - الألوان والخطوط والمسافات
    @Environment(\.appTheme) var theme
    
    /// الـ Localization Manager - لتغيير اللغة
    @StateObject private var localizationManager = LocalizationManager.shared
    
    // MARK: - Local State
    
    /// للتحكم في الـ Alerts
    @State private var showAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    
    /// للتحكم في الـ Sheets
    @State private var showSheet = false
    
    /// للـ Pull to Refresh
    @State private var isRefreshing = false
    
    // MARK: - Body
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: theme.spacing.lg) {
                    // MARK: - Header
                    headerSection
                    
                    // MARK: - 1. Buttons Section
                    buttonExamplesSection
                    
                    // MARK: - 2. TextFields Section
                    textFieldExamplesSection
                    
                    // MARK: - 3. Form Example
                    formExampleSection
                    
                    // MARK: - 4. Toggle & Picker Section
                    toggleAndPickerSection
                    
                    // MARK: - 5. API Examples
                    apiExamplesSection
                    
                    // MARK: - 6. State Views Section
                    stateViewsSection
                    
                    // MARK: - 7. Lists Section
                    listsSection
                    
                    // MARK: - 8. Navigation Examples
                    navigationExamplesSection
                    
                    // Spacer في النهاية
                    Spacer(minLength: 40)
                }
                .padding(theme.spacing.md)
            }
            .navigationTitle("صفحة التدريب")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                // زر الرجوع
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        navigator.pop()
                    }) {
                        HStack(spacing: 4) {
                            Image(systemName: "chevron.left")
                            Text("رجوع")
                        }
                    }
                }
                
                // زر تغيير اللغة
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: toggleLanguage) {
                        Image(systemName: "globe")
                    }
                }
            }
            .alert(alertTitle, isPresented: $showAlert) {
                Button("حسناً", role: .cancel) { }
            } message: {
                Text(alertMessage)
            }
            .sheet(isPresented: $showSheet) {
                sheetContent
            }
            .refreshable {
                // Pull to Refresh - اسحب للتحديث
                await refreshData()
            }
        }
    }
    
    // MARK: - Header Section
    // ========================================
    
    private var headerSection: some View {
        VStack(alignment: .leading, spacing: theme.spacing.md) {
            Text("🎓 مرحباً بك في صفحة التدريب!")
                .font(theme.typography.headlineLarge)
                .foregroundColor(theme.colors.onBackground)
            
            Text("هذه الصفحة تحتوي على أمثلة كاملة لكل شيء في التطبيق:")
                .font(theme.typography.bodyMedium)
                .foregroundColor(theme.colors.onBackground.opacity(0.7))
            
            VStack(alignment: .leading, spacing: theme.spacing.xs) {
                FeatureItem(icon: "checkmark.circle.fill", text: "جميع أنواع الـ Buttons")
                FeatureItem(icon: "checkmark.circle.fill", text: "جميع أنواع الـ TextFields")
                FeatureItem(icon: "checkmark.circle.fill", text: "Form كامل مع Validation")
                FeatureItem(icon: "checkmark.circle.fill", text: "Toggle, Picker, Switch")
                FeatureItem(icon: "checkmark.circle.fill", text: "أمثلة على API Calls")
                FeatureItem(icon: "checkmark.circle.fill", text: "Loading, Error, Empty States")
                FeatureItem(icon: "checkmark.circle.fill", text: "Lists & ScrollViews")
                FeatureItem(icon: "checkmark.circle.fill", text: "Navigation Examples")
            }
            .font(theme.typography.bodySmall)
            .foregroundColor(theme.colors.onBackground.opacity(0.6))
        }
        .padding(theme.spacing.lg)
        .background(theme.colors.surfaceVariant)
        .cornerRadius(12)
    }
    
    // MARK: - 1. Buttons Section
    // ========================================
    
    private var buttonExamplesSection: some View {
        TrainingSectionView(
            title: "1. أمثلة على الأزرار (Buttons)",
            icon: "hand.tap.fill"
        ) {
            VStack(spacing: theme.spacing.md) {
                // Primary Button
                CommentedView(comment: "زر أساسي - Primary Button") {
                    AppButton(
                        "زر أساسي",
                        style: .primary,
                        state: .normal
                    ) {
                        showSimpleAlert(title: "تم الضغط", message: "تم الضغط على الزر الأساسي")
                    }
                }
                
                // Secondary Button
                CommentedView(comment: "زر ثانوي - Secondary Button") {
                    AppButton(
                        "زر ثانوي",
                        style: .secondary,
                        state: .normal
                    ) {
                        showSimpleAlert(title: "تم الضغط", message: "تم الضغط على الزر الثانوي")
                    }
                }
                
                // Outlined Button
                CommentedView(comment: "زر بإطار - Outlined Button") {
                    AppButton(
                        "زر بإطار",
                        style: .outlined,
                        state: .normal
                    ) {
                        showSimpleAlert(title: "تم الضغط", message: "تم الضغط على الزر بإطار")
                    }
                }
                
                // Ghost Button
                CommentedView(comment: "زر شفاف - Ghost Button") {
                    AppButton(
                        "زر شفاف",
                        style: .ghost,
                        state: .normal
                    ) {
                        showSimpleAlert(title: "تم الضغط", message: "تم الضغط على الزر الشفاف")
                    }
                }
                
                // Loading Button
                CommentedView(comment: "زر مع تحميل - Loading Button") {
                    AppButton(
                        "جاري التحميل...",
                        style: .primary,
                        state: .loading
                    ) {
                        // لا يعمل أثناء التحميل
                    }
                }
                
                // Disabled Button
                CommentedView(comment: "زر معطل - Disabled Button") {
                    AppButton(
                        "زر معطل",
                        style: .primary,
                        state: .disabled
                    ) {
                        // لن يعمل
                    }
                }
                
                // Button with Icon
                CommentedView(comment: "زر عادي مع أيقونة") {
                    Button(action: {
                        showSimpleAlert(title: "تم الضغط", message: "زر مع أيقونة")
                    }) {
                        HStack {
                            Image(systemName: "heart.fill")
                            Text("أعجبني")
                        }
                        .frame(maxWidth: .infinity)
                        .padding(theme.spacing.md)
                        .background(theme.colors.error)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                    }
                }
            }
        }
    }
    
    // MARK: - 2. TextFields Section
    // ========================================
    
    private var textFieldExamplesSection: some View {
        TrainingSectionView(
            title: "2. أمثلة على حقول النص (TextFields)",
            icon: "keyboard"
        ) {
            VStack(spacing: theme.spacing.md) {
                // Normal TextField
                CommentedView(comment: "حقل نص عادي - Normal") {
                    AppTextField(
                        placeholder: "أدخل اسمك",
                        text: $viewModel.nameField
                    )
                }
                
                // Error TextField
                CommentedView(comment: "حقل نص مع خطأ - Error State") {
                    VStack(alignment: .leading, spacing: theme.spacing.xs) {
                        TextField("حقل فارغ", text: .constant(""))
                            .padding(theme.spacing.md)
                            .background(theme.colors.surfaceVariant)
                            .cornerRadius(8)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(theme.colors.error, lineWidth: 1)
                            )
                        
                        Text("هذا الحقل مطلوب")
                            .font(theme.typography.bodySmall)
                            .foregroundColor(theme.colors.error)
                    }
                }
                
                // Success TextField
                CommentedView(comment: "حقل نص مع نجاح - Success State") {
                    VStack(alignment: .leading, spacing: theme.spacing.xs) {
                        TextField("البريد الإلكتروني", text: .constant("test@example.com"))
                            .padding(theme.spacing.md)
                            .background(theme.colors.surfaceVariant)
                            .cornerRadius(8)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(theme.colors.success, lineWidth: 1)
                            )
                        
                        Text("تم التحقق بنجاح")
                            .font(theme.typography.bodySmall)
                            .foregroundColor(theme.colors.success)
                    }
                }
                
                // Loading TextField
                CommentedView(comment: "حقل نص مع تحميل - Loading State") {
                    HStack {
                        TextField("جاري التحقق...", text: .constant("checking..."))
                            .padding(theme.spacing.md)
                        
                        ProgressView()
                            .padding(.trailing, theme.spacing.md)
                    }
                    .background(theme.colors.surfaceVariant)
                    .cornerRadius(8)
                }
                
                // Secure TextField (Password)
                CommentedView(comment: "حقل كلمة المرور - Secure Field") {
                    SecureField("كلمة المرور", text: $viewModel.passwordField)
                        .padding(theme.spacing.md)
                        .background(theme.colors.surfaceVariant)
                        .cornerRadius(8)
                }
                
                // TextEditor (Multiple lines)
                CommentedView(comment: "حقل نص متعدد الأسطر - TextEditor") {
                    TextEditor(text: $viewModel.bioField)
                        .frame(height: 100)
                        .padding(theme.spacing.sm)
                        .background(theme.colors.surfaceVariant)
                        .cornerRadius(8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(theme.colors.divider, lineWidth: 1)
                        )
                }
            }
        }
    }
    
    // MARK: - 3. Form Example Section
    // ========================================
    
    private var formExampleSection: some View {
        TrainingSectionView(
            title: "3. مثال على Form كامل مع Validation",
            icon: "doc.text.fill"
        ) {
            VStack(spacing: theme.spacing.md) {
                // Name Field
                CommentedView(comment: "حقل الاسم - مطلوب، 3 أحرف على الأقل") {
                    VStack(alignment: .leading, spacing: theme.spacing.xs) {
                        TextField("الاسم الكامل *", text: $viewModel.nameField)
                            .padding(theme.spacing.md)
                            .background(theme.colors.surfaceVariant)
                            .cornerRadius(8)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(
                                        viewModel.nameFieldState.borderColor(theme),
                                        lineWidth: 1
                                    )
                            )
                        
                        if case .error(let message) = viewModel.nameFieldState {
                            Text(message)
                                .font(theme.typography.bodySmall)
                                .foregroundColor(theme.colors.error)
                        }
                        
                        if case .success(let message) = viewModel.nameFieldState {
                            Text(message)
                                .font(theme.typography.bodySmall)
                                .foregroundColor(theme.colors.success)
                        }
                    }
                }
                
                // Email Field
                CommentedView(comment: "حقل البريد - مطلوب، يجب أن يكون إيميل صحيح") {
                    VStack(alignment: .leading, spacing: theme.spacing.xs) {
                        TextField("البريد الإلكتروني *", text: $viewModel.emailField)
                            .padding(theme.spacing.md)
                            .background(theme.colors.surfaceVariant)
                            .cornerRadius(8)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(
                                        viewModel.emailFieldState.borderColor(theme),
                                        lineWidth: 1
                                    )
                            )
                        
                        if case .error(let message) = viewModel.emailFieldState {
                            Text(message)
                                .font(theme.typography.bodySmall)
                                .foregroundColor(theme.colors.error)
                        }
                        
                        if case .success(let message) = viewModel.emailFieldState {
                            Text(message)
                                .font(theme.typography.bodySmall)
                                .foregroundColor(theme.colors.success)
                        }
                    }
                }
                
                // Password Field
                CommentedView(comment: "حقل كلمة المرور - مطلوب، 6 أحرف على الأقل") {
                    VStack(alignment: .leading, spacing: theme.spacing.xs) {
                        SecureField("كلمة المرور *", text: $viewModel.passwordField)
                            .padding(theme.spacing.md)
                            .background(theme.colors.surfaceVariant)
                            .cornerRadius(8)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(
                                        viewModel.passwordFieldState.borderColor(theme),
                                        lineWidth: 1
                                    )
                            )
                        
                        if case .error(let message) = viewModel.passwordFieldState {
                            Text(message)
                                .font(theme.typography.bodySmall)
                                .foregroundColor(theme.colors.error)
                        }
                    }
                }
                
                // Phone Field (Optional)
                CommentedView(comment: "حقل الهاتف - اختياري") {
                    TextField("رقم الهاتف (اختياري)", text: $viewModel.phoneField)
                        .padding(theme.spacing.md)
                        .background(theme.colors.surfaceVariant)
                        .cornerRadius(8)
                }
                
                // Terms Checkbox
                CommentedView(comment: "موافقة على الشروط") {
                    Toggle(isOn: $viewModel.agreeToTerms) {
                        Text("أوافق على الشروط والأحكام")
                            .font(theme.typography.bodyMedium)
                    }
                }
                
                // Submit Button
                CommentedView(comment: "زر الإرسال - يعمل Validation ويرسل للـ API") {
                    AppButton(
                        "حفظ البيانات",
                        style: .primary,
                        state: viewModel.state == .loading ? .loading : (!viewModel.agreeToTerms ? .disabled : .normal)
                    ) {
                        viewModel.saveForm()
                    }
                }
                
                // Clear Button
                Button(action: {
                    viewModel.clearForm()
                }) {
                    Text("مسح الحقول")
                        .font(theme.typography.bodyMedium)
                        .foregroundColor(theme.colors.error)
                }
            }
        }
    }
    
    // MARK: - 4. Toggle & Picker Section
    // ========================================
    
    private var toggleAndPickerSection: some View {
        TrainingSectionView(
            title: "4. Toggle, Picker, Switch",
            icon: "switch.2"
        ) {
            VStack(spacing: theme.spacing.md) {
                // Toggle 1
                CommentedView(comment: "Toggle - للتفعيل/التعطيل") {
                    Toggle(isOn: $viewModel.isNotificationsEnabled) {
                        HStack {
                            Image(systemName: "bell.fill")
                                .foregroundColor(theme.colors.primary)
                            Text("تفعيل الإشعارات")
                                .font(theme.typography.bodyMedium)
                        }
                    }
                    .tint(theme.colors.primary)
                }
                
                // Toggle 2
                CommentedView(comment: "Toggle - Dark Mode") {
                    Toggle(isOn: $viewModel.isDarkModeEnabled) {
                        HStack {
                            Image(systemName: "moon.fill")
                                .foregroundColor(theme.colors.secondary)
                            Text("الوضع الليلي")
                                .font(theme.typography.bodyMedium)
                        }
                    }
                    .tint(theme.colors.secondary)
                }
                
                Divider()
                
                // Picker - Country
                CommentedView(comment: "Picker - اختيار من قائمة") {
                    VStack(alignment: .leading, spacing: theme.spacing.sm) {
                        Text("الدولة")
                            .font(theme.typography.labelMedium)
                            .foregroundColor(theme.colors.onBackground.opacity(0.7))
                        
                        Picker("الدولة", selection: $viewModel.selectedCountry) {
                            ForEach(viewModel.countries, id: \.self) { country in
                                Text(country).tag(country)
                            }
                        }
                        .pickerStyle(.menu)
                        .padding(theme.spacing.sm)
                        .background(theme.colors.surfaceVariant)
                        .cornerRadius(8)
                    }
                }
                
                // Picker - Gender (Segmented)
                CommentedView(comment: "Segmented Picker - اختيار بين خيارين") {
                    VStack(alignment: .leading, spacing: theme.spacing.sm) {
                        Text("الجنس")
                            .font(theme.typography.labelMedium)
                            .foregroundColor(theme.colors.onBackground.opacity(0.7))
                        
                        Picker("الجنس", selection: $viewModel.selectedGender) {
                            ForEach(viewModel.genders, id: \.self) { gender in
                                Text(gender).tag(gender)
                            }
                        }
                        .pickerStyle(.segmented)
                    }
                }
            }
        }
    }
    
    // MARK: - 5. API Examples Section
    // ========================================
    
    private var apiExamplesSection: some View {
        TrainingSectionView(
            title: "5. أمثلة على API Calls",
            icon: "network"
        ) {
            VStack(spacing: theme.spacing.md) {
                // Explanation
                CommentedView(comment: "استخدمنا JSONPlaceholder - API مجاني للتجربة") {
                    Text("📡 API: https://jsonplaceholder.typicode.com")
                        .font(theme.typography.bodySmall)
                        .foregroundColor(theme.colors.onBackground.opacity(0.6))
                        .padding(theme.spacing.sm)
                        .background(theme.colors.surfaceVariant)
                        .cornerRadius(8)
                }
                
                // Fetch Data Button
                CommentedView(comment: "زر لجلب البيانات من API") {
                    AppButton(
                        "جلب البيانات من API",
                        style: .primary,
                        state: viewModel.state == .loading ? .loading : .normal
                    ) {
                        viewModel.fetchData()
                    }
                }
                
                // State Display
                switch viewModel.state {
                case .idle:
                    CommentedView(comment: "حالة البداية - Idle State") {
                        Text("اضغط على الزر لجلب البيانات")
                            .font(theme.typography.bodyMedium)
                            .foregroundColor(theme.colors.onBackground.opacity(0.6))
                            .padding(theme.spacing.md)
                    }
                    
                case .loading:
                    CommentedView(comment: "حالة التحميل - Loading State") {
                        LoadingView(message: "جاري جلب البيانات...")
                    }
                    
                case .success:
                    CommentedView(comment: "حالة النجاح - Success State") {
                        VStack(spacing: theme.spacing.sm) {
                            HStack {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(theme.colors.success)
                                Text("تم جلب البيانات بنجاح!")
                                    .font(theme.typography.bodyMedium)
                                    .foregroundColor(theme.colors.success)
                            }
                            .padding(theme.spacing.md)
                            .background(theme.colors.success.opacity(0.1))
                            .cornerRadius(8)
                            
                            Text("عدد المستخدمين: \(viewModel.users.count)")
                                .font(theme.typography.bodySmall)
                            Text("عدد المنشورات: \(viewModel.posts.count)")
                                .font(theme.typography.bodySmall)
                        }
                    }
                    
                case .error(let message):
                    CommentedView(comment: "حالة الخطأ - Error State") {
                        VStack(spacing: theme.spacing.sm) {
                            HStack {
                                Image(systemName: "exclamationmark.triangle.fill")
                                    .foregroundColor(theme.colors.error)
                                Text("حدث خطأ!")
                                    .font(theme.typography.bodyMedium)
                                    .foregroundColor(theme.colors.error)
                            }
                            
                            Text(message)
                                .font(theme.typography.bodySmall)
                                .foregroundColor(theme.colors.onBackground.opacity(0.7))
                                .multilineTextAlignment(.center)
                        }
                        .padding(theme.spacing.md)
                        .background(theme.colors.error.opacity(0.1))
                        .cornerRadius(8)
                    }
                }
            }
        }
    }
    
    // MARK: - 6. State Views Section
    // ========================================
    
    private var stateViewsSection: some View {
        TrainingSectionView(
            title: "6. State Views (Loading, Empty, Error)",
            icon: "square.stack.3d.up.fill"
        ) {
            VStack(spacing: theme.spacing.md) {
                // Loading View
                CommentedView(comment: "Loading View - شاشة التحميل") {
                    LoadingView(message: "جاري التحميل...")
                        .frame(height: 100)
                }
                
                // Empty State View
                CommentedView(comment: "Empty State - لا توجد بيانات") {
                    EmptyStateView(
                        title: "لا توجد بيانات",
                        message: "لم يتم العثور على أي عناصر"
                    )
                    .frame(height: 150)
                }
                
                // Error State View
                CommentedView(comment: "Error State - حدث خطأ") {
                    ErrorStateView(
                        message: "حدث خطأ أثناء تحميل البيانات"
                    ) {
                        showSimpleAlert(title: "إعادة المحاولة", message: "تم الضغط على إعادة المحاولة")
                    }
                    .frame(height: 150)
                }
            }
        }
    }
    
    // MARK: - 7. Lists Section
    // ========================================
    
    private var listsSection: some View {
        TrainingSectionView(
            title: "7. قوائم (Lists)",
            icon: "list.bullet"
        ) {
            VStack(spacing: theme.spacing.md) {
                CommentedView(comment: "List - قائمة المستخدمين من API") {
                    if viewModel.users.isEmpty {
                        Text("اضغط 'جلب البيانات' أعلاه لرؤية القائمة")
                            .font(theme.typography.bodySmall)
                            .foregroundColor(theme.colors.onBackground.opacity(0.6))
                            .padding(theme.spacing.md)
                    } else {
                        VStack(spacing: theme.spacing.sm) {
                            ForEach(viewModel.users.prefix(5)) { user in
                                UserRowView(user: user)
                            }
                        }
                    }
                }
            }
        }
    }
    
    // MARK: - 8. Navigation Examples Section
    // ========================================
    
    private var navigationExamplesSection: some View {
        TrainingSectionView(
            title: "8. أمثلة على التنقل (Navigation)",
            icon: "arrow.triangle.branch"
        ) {
            VStack(spacing: theme.spacing.md) {
                // Alert
                CommentedView(comment: "عرض Alert") {
                    Button(action: {
                        showSimpleAlert(
                            title: "تنبيه",
                            message: "هذا مثال على Alert بسيط"
                        )
                    }) {
                        HStack {
                            Image(systemName: "bell.badge.fill")
                            Text("عرض Alert")
                        }
                        .frame(maxWidth: .infinity)
                        .padding(theme.spacing.md)
                        .background(theme.colors.info)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                    }
                }
                
                // Sheet
                CommentedView(comment: "عرض Sheet (Modal من الأسفل)") {
                    Button(action: {
                        showSheet = true
                    }) {
                        HStack {
                            Image(systemName: "square.and.arrow.up")
                            Text("عرض Sheet")
                        }
                        .frame(maxWidth: .infinity)
                        .padding(theme.spacing.md)
                        .background(theme.colors.secondary)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                    }
                }
                
                // Navigate to Home
                CommentedView(comment: "الانتقال لصفحة أخرى") {
                    Button(action: {
                        navigator.popToRoot()
                    }) {
                        HStack {
                            Image(systemName: "house.fill")
                            Text("الرجوع للرئيسية")
                        }
                        .frame(maxWidth: .infinity)
                        .padding(theme.spacing.md)
                        .background(theme.colors.surfaceVariant)
                        .foregroundColor(theme.colors.onSurface)
                        .cornerRadius(8)
                    }
                }
            }
        }
    }
    
    // MARK: - Helper Methods
    // ========================================
    
    /// عرض Alert بسيط
    private func showSimpleAlert(title: String, message: String) {
        alertTitle = title
        alertMessage = message
        showAlert = true
    }
    
    /// تغيير اللغة
    private func toggleLanguage() {
        if localizationManager.currentLanguage == .english {
            localizationManager.setLanguage(.arabic)
        } else {
            localizationManager.setLanguage(.english)
        }
    }
    
    /// Pull to Refresh
    private func refreshData() async {
        isRefreshing = true
        
        // محاكاة التحديث
        try? await Task.sleep(nanoseconds: 1_500_000_000)
        
        viewModel.fetchData()
        
        isRefreshing = false
    }
    
    // MARK: - Sheet Content
    
    private var sheetContent: some View {
        VStack(spacing: theme.spacing.lg) {
            Text("مثال على Sheet")
                .font(theme.typography.headlineLarge)
                .foregroundColor(theme.colors.onBackground)
            
            Text("هذا مثال على Sheet (Modal) يظهر من الأسفل")
                .font(theme.typography.bodyMedium)
                .foregroundColor(theme.colors.onBackground.opacity(0.7))
                .multilineTextAlignment(.center)
            
            Button(action: {
                showSheet = false
            }) {
                Text("إغلاق")
                    .frame(maxWidth: .infinity)
                    .padding(theme.spacing.md)
                    .background(theme.colors.primary)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            
            Spacer()
        }
        .padding(theme.spacing.lg)
    }
}

// MARK: - Supporting Views
// ========================================

/// عرض قسم في الصفحة التدريبية
struct TrainingSectionView<Content: View>: View {
    let title: String
    let icon: String
    let content: Content
    @Environment(\.appTheme) var theme
    
    init(title: String, icon: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.icon = icon
        self.content = content()
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: theme.spacing.md) {
            // Section Header
            HStack(spacing: theme.spacing.sm) {
                Image(systemName: icon)
                    .foregroundColor(theme.colors.primary)
                    .font(.system(size: 20, weight: .semibold))
                
                Text(title)
                    .font(theme.typography.titleLarge)
                    .foregroundColor(theme.colors.onBackground)
            }
            
            // Section Content
            VStack(spacing: theme.spacing.md) {
                content
            }
            .padding(theme.spacing.md)
            .background(theme.colors.surface)
            .cornerRadius(12)
            .shadow(
                color: theme.shadows.elevation1.color.opacity(theme.shadows.elevation1.opacity),
                radius: theme.shadows.elevation1.radius,
                x: theme.shadows.elevation1.offsetX,
                y: theme.shadows.elevation1.offsetY
            )
        }
    }
}

/// عرض مع تعليق
struct CommentedView<Content: View>: View {
    let comment: String
    let content: Content
    @Environment(\.appTheme) var theme
    
    init(comment: String, @ViewBuilder content: () -> Content) {
        self.comment = comment
        self.content = content()
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: theme.spacing.xs) {
            // Comment
            Text("💡 \(comment)")
                .font(theme.typography.bodySmall)
                .foregroundColor(theme.colors.primary)
                .padding(.horizontal, theme.spacing.sm)
                .padding(.vertical, theme.spacing.xs)
                .background(theme.colors.primary.opacity(0.1))
                .cornerRadius(6)
            
            // Content
            content
        }
    }
}

/// عنصر في قائمة المميزات
struct FeatureItem: View {
    let icon: String
    let text: String
    @Environment(\.appTheme) var theme
    
    var body: some View {
        HStack(spacing: theme.spacing.xs) {
            Image(systemName: icon)
                .foregroundColor(theme.colors.success)
                .font(.system(size: 12))
            Text(text)
        }
    }
}

/// صف مستخدم في القائمة
struct UserRowView: View {
    let user: User
    @Environment(\.appTheme) var theme
    
    var body: some View {
        HStack(spacing: theme.spacing.md) {
            // Avatar
            Circle()
                .fill(theme.colors.primary)
                .frame(width: 40, height: 40)
                .overlay(
                    Text(String(user.name.prefix(1)))
                        .font(theme.typography.titleMedium)
                        .foregroundColor(.white)
                )
            
            // Info
            VStack(alignment: .leading, spacing: theme.spacing.xs) {
                Text(user.name)
                    .font(theme.typography.bodyMedium)
                    .foregroundColor(theme.colors.onBackground)
                
                Text(user.email)
                    .font(theme.typography.bodySmall)
                    .foregroundColor(theme.colors.onBackground.opacity(0.6))
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .font(.system(size: 12))
                .foregroundColor(theme.colors.onBackground.opacity(0.3))
        }
        .padding(theme.spacing.md)
        .background(theme.colors.surfaceVariant)
        .cornerRadius(8)
    }
}

// MARK: - TextField State Extension
// ========================================

extension TextFieldState {
    /// لون الحدود بناءً على الحالة
    func borderColor(_ theme: AppTheme) -> Color {
        switch self {
        case .normal:
            return theme.colors.divider
        case .error:
            return theme.colors.error
        case .success:
            return theme.colors.success
        case .loading:
            return theme.colors.primary
        }
    }
}

// MARK: - Preview
// ========================================

#Preview {
    TrainingView(navigator: Navigator())
        .appTheme(AppTheme())
}
