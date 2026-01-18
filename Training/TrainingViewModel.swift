import SwiftUI
import Combine

// MARK: - Training Models
// ========================================
// الموديلات اللي راح نستخدمها في الصفحة

/// User Model - مثال على موديل من API
struct User: Codable, Identifiable {
    let id: Int
    let name: String
    let email: String
    let phone: String?
    
    // مثال: Fake User للتجربة بدون API
    static let fake = User(
        id: 1,
        name: "أحمد محمد",
        email: "ahmed@example.com",
        phone: "0501234567"
    )
}

/// Post Model - مثال ثاني
struct Post: Codable, Identifiable {
    let id: Int
    let userId: Int
    let title: String
    let body: String
}

// MARK: - API Service
// ========================================
// السيرفس اللي راح يتعامل مع الـ API

class TrainingAPIService {
    // Singleton Pattern - instance واحد بس في كل التطبيق
    static let shared = TrainingAPIService()
    private init() {}
    
    // Base URL للـ API
    // استخدمنا JSONPlaceholder - API مجاني للتجربة
    private let baseURL = "https://jsonplaceholder.typicode.com"
    
    // MARK: - Fetch Users
    /// جلب قائمة المستخدمين من API
    /// - Returns: مصفوفة من Users
    func fetchUsers() async throws -> [User] {
        // 1. بناء الـ URL
        guard let url = URL(string: "\(baseURL)/users") else {
            throw NetworkError.invalidURL
        }
        
        // 2. إنشاء الـ Request
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // 3. إرسال الـ Request والحصول على Response
        let (data, response) = try await URLSession.shared.data(for: request)
        
        // 4. التحقق من الـ Response
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            let statusCode = (response as? HTTPURLResponse)?.statusCode ?? 500
            throw NetworkError.serverError(code: statusCode, message: "Server error with status code: \(statusCode)")
        }
        
        // 5. فك تشفير الـ JSON إلى Objects
        let users = try JSONDecoder().decode([User].self, from: data)
        
        #if DEBUG
        print("✅ [API] تم جلب \(users.count) مستخدم بنجاح")
        #endif
        
        return users
    }
    
    // MARK: - Fetch Posts
    /// جلب المنشورات من API
    func fetchPosts() async throws -> [Post] {
        guard let url = URL(string: "\(baseURL)/posts") else {
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            let statusCode = (response as? HTTPURLResponse)?.statusCode ?? 500
            throw NetworkError.serverError(code: statusCode, message: "Server error with status code: \(statusCode)")
        }
        
        let posts = try JSONDecoder().decode([Post].self, from: data)
        
        #if DEBUG
        print("✅ [API] تم جلب \(posts.count) منشور بنجاح")
        #endif
        
        return posts
    }
    
    // MARK: - Create User (POST Request)
    /// إنشاء مستخدم جديد - مثال على POST request
    /// - Parameter user: بيانات المستخدم
    /// - Returns: المستخدم المُنشأ
    func createUser(name: String, email: String) async throws -> User {
        guard let url = URL(string: "\(baseURL)/users") else {
            throw NetworkError.invalidURL
        }
        
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
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            let statusCode = (response as? HTTPURLResponse)?.statusCode ?? 500
            throw NetworkError.serverError(code: statusCode, message: "Server error with status code: \(statusCode)")
        }
        
        let user = try JSONDecoder().decode(User.self, from: data)
        
        #if DEBUG
        print("✅ [API] تم إنشاء المستخدم بنجاح: \(user.name)")
        #endif
        
        return user
    }
}

// MARK: - View States
// ========================================
// حالات الصفحة المختلفة

enum ViewState: Equatable {
    case idle        // حالة البداية
    case loading     // جاري التحميل
    case success     // نجح
    case error(String) // حدث خطأ
}

// MARK: - Training ViewModel
// ========================================
// الـ ViewModel - يحتوي على كل البيزنس لوجك

@MainActor
class TrainingViewModel: ObservableObject {
    // MARK: - Published Properties
    // الـ Properties اللي راح تتغير وتحدث الـ View
    
    /// حالة الصفحة الحالية
    @Published var state: ViewState = .idle
    
    /// قائمة المستخدمين من API
    @Published var users: [User] = []
    
    /// قائمة المنشورات
    @Published var posts: [Post] = []
    
    // MARK: - Form Fields
    // حقول الفورم
    
    @Published var nameField: String = ""
    @Published var emailField: String = ""
    @Published var passwordField: String = ""
    @Published var phoneField: String = ""
    @Published var bioField: String = ""
    
    // MARK: - Form States
    // حالات الحقول
    
    @Published var nameFieldState: TextFieldState = .normal
    @Published var emailFieldState: TextFieldState = .normal
    @Published var passwordFieldState: TextFieldState = .normal
    
    // MARK: - Toggle & Picker States
    
    @Published var isNotificationsEnabled: Bool = true
    @Published var isDarkModeEnabled: Bool = false
    @Published var agreeToTerms: Bool = false
    
    @Published var selectedCountry: String = "السعودية"
    let countries = ["السعودية", "الإمارات", "الكويت", "قطر", "البحرين", "عمان"]
    
    @Published var selectedGender: String = "ذكر"
    let genders = ["ذكر", "أنثى"]
    
    // MARK: - API Service
    private let apiService = TrainingAPIService.shared
    
    // MARK: - Methods
    
    /// جلب البيانات من API
    func fetchData() {
        Task {
            // تغيير الحالة إلى Loading
            state = .loading
            
            do {
                // محاولة جلب البيانات
                users = try await apiService.fetchUsers()
                posts = try await apiService.fetchPosts()
                
                // نجح! تغيير الحالة
                state = .success
                
            } catch {
                // حدث خطأ
                state = .error(error.localizedDescription)
                
                #if DEBUG
                print("❌ [API Error] \(error)")
                #endif
            }
        }
    }
    
    /// حفظ الفورم - Validation مثال
    func saveForm() {
        // 1. تنظيف الحالات السابقة
        nameFieldState = .normal
        emailFieldState = .normal
        passwordFieldState = .normal
        
        // 2. Validation
        var hasError = false
        
        // التحقق من الاسم
        if nameField.isEmpty {
            nameFieldState = .error("الرجاء إدخال الاسم")
            hasError = true
        } else if nameField.count < 3 {
            nameFieldState = .error("الاسم يجب أن يكون 3 أحرف على الأقل")
            hasError = true
        }
        
        // التحقق من الإيميل
        if emailField.isEmpty {
            emailFieldState = .error("الرجاء إدخال البريد الإلكتروني")
            hasError = true
        } else if !isValidEmail(emailField) {
            emailFieldState = .error("البريد الإلكتروني غير صحيح")
            hasError = true
        }
        
        // التحقق من كلمة المرور
        if passwordField.isEmpty {
            passwordFieldState = .error("الرجاء إدخال كلمة المرور")
            hasError = true
        } else if passwordField.count < 6 {
            passwordFieldState = .error("كلمة المرور يجب أن تكون 6 أحرف على الأقل")
            hasError = true
        }
        
        // إذا في أخطاء، نوقف
        if hasError {
            return
        }
        
        // 3. كل شي تمام، نرسل للـ API
        Task {
            state = .loading
            
            do {
                let user = try await apiService.createUser(
                    name: nameField,
                    email: emailField
                )
                
                // نجح! نعرض Success state
                nameFieldState = .success("تم الحفظ بنجاح!")
                emailFieldState = .success("تم التحقق")
                state = .success
                
                #if DEBUG
                print("✅ تم إنشاء المستخدم: \(user.name)")
                #endif
                
                // نظف الحقول بعد ثانيتين
                try? await Task.sleep(nanoseconds: 2_000_000_000)
                clearForm()
                
            } catch {
                state = .error("فشل الحفظ: \(error.localizedDescription)")
            }
        }
    }
    
    /// تنظيف الفورم
    func clearForm() {
        nameField = ""
        emailField = ""
        passwordField = ""
        phoneField = ""
        bioField = ""
        
        nameFieldState = .normal
        emailFieldState = .normal
        passwordFieldState = .normal
    }
    
    /// التحقق من صحة الإيميل
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    /// محاكاة عملية طويلة (مثل رفع صورة)
    func simulateLongOperation() {
        Task {
            state = .loading
            
            // انتظر 3 ثواني (محاكاة)
            try? await Task.sleep(nanoseconds: 3_000_000_000)
            
            state = .success
        }
    }
}

// MARK: - TextField State
// ========================================
// حالات الـ TextField المختلفة

enum TextFieldState {
    case normal
    case error(String)
    case success(String)
    case loading
}
