import SwiftUI
import Foundation

// MARK: - String Extensions

extension String {
    /// Checks if string is empty or contains only whitespace
    var isBlank: Bool {
        trimmingCharacters(in: .whitespaces).isEmpty
    }

    /// Validates email format
    var isValidEmail: Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let predicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return predicate.evaluate(with: self)
    }

    /// Validates phone number format (basic)
    var isValidPhone: Bool {
        let phoneRegex = "^[0-9\\s\\-\\(\\)\\+]+$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        return predicate.evaluate(with: self) && count >= 10
    }
}

// MARK: - Date Extensions

extension Date {
    /// Formats date to string
    func formatted(format: String = "yyyy-MM-dd HH:mm:ss") -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }

    /// Returns the number of days from now
    var daysFromNow: Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: Date(), to: self)
        return components.day ?? 0
    }

    /// Checks if date is today
    var isToday: Bool {
        Calendar.current.isDateInToday(self)
    }

    /// Checks if date is tomorrow
    var isTomorrow: Bool {
        Calendar.current.isDateInTomorrow(self)
    }

    /// Checks if date is yesterday
    var isYesterday: Bool {
        Calendar.current.isDateInYesterday(self)
    }
}

// MARK: - View Extensions

extension View {
    /// Adds a card-like appearance
    func cardStyle(_ theme: AppTheme) -> some View {
        self
            .padding(theme.spacing.md)
            .background(theme.colors.surface)
            .cornerRadius(12)
            .shadow(
                color: theme.colors.onBackground.opacity(0.1),
                radius: 4,
                x: 0,
                y: 2
            )
    }

    /// Hides keyboard
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }

    /// Adds conditional modifier
    @ViewBuilder
    func `if`<Content: View>(
        _ condition: Bool,
        transform: (Self) -> Content
    ) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }

    /// Adds loading overlay
    func withLoadingOverlay(_ isLoading: Bool) -> some View {
        ZStack {
            self
            if isLoading {
                LoadingView(message: "Loading...")
            }
        }
    }
}

// MARK: - Collection Extensions

extension Array {
    /// Safely access element at index
    func element(at index: Int) -> Element? {
        indices.contains(index) ? self[index] : nil
    }

    /// Removes duplicates by key
    func removingDuplicates<T: Equatable>(by key: (Element) -> T) -> [Element] {
        var result: [Element] = []
        var keys: [T] = []

        for element in self {
            let key = key(element)
            if !keys.contains(key) {
                result.append(element)
                keys.append(key)
            }
        }

        return result
    }
}

// MARK: - UserDefaults Extensions

extension UserDefaults {
    /// Stores Codable object
    func set<T: Encodable>(_ value: T, forKey key: String) {
        guard let encoded = try? JSONEncoder().encode(value) else { return }
        self.set(encoded, forKey: key)
    }

    /// Retrieves Codable object
    func object<T: Decodable>(_ type: T.Type, forKey key: String) -> T? {
        guard let data = self.data(forKey: key),
              let object = try? JSONDecoder().decode(type, from: data) else {
            return nil
        }
        return object
    }
}

// MARK: - Bundle Extensions

extension Bundle {
    /// Gets app version
    var appVersion: String {
        infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0"
    }

    /// Gets build number
    var buildNumber: String {
        infoDictionary?["CFBundleVersion"] as? String ?? "1"
    }

    /// Gets app name
    var appName: String {
        infoDictionary?["CFBundleName"] as? String ?? "App"
    }
}

// MARK: - Codable Extensions

extension JSONDecoder {
    /// Convenience decoder with common settings
    static let `default`: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }()
}

extension JSONEncoder {
    /// Convenience encoder with common settings
    static let `default`: JSONEncoder = {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        return encoder
    }()
}

// MARK: - Double Extensions

extension Double {
    /// Rounds to given decimal places
    func rounded(to places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }

    /// Formats as currency
    func asCurrency(locale: Locale = .current) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = locale
        return formatter.string(from: NSNumber(value: self)) ?? "\(self)"
    }
}

// MARK: - Color Extensions

extension Color {
    /// Creates color from hex string
    init(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespaces)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgb)

        let red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgb & 0x0000FF) / 255.0

        self.init(red: red, green: green, blue: blue)
    }

    /// Gets hex string representation
    var hexString: String? {
        guard let cgColor = self.cgColor else { return nil }
        let components = cgColor.components ?? [0, 0, 0, 1]
        let red = Int(components[0] * 255.0)
        let green = Int(components[1] * 255.0)
        let blue = Int(components[2] * 255.0)
        return String(format: "#%02X%02X%02X", red, green, blue)
    }
}
