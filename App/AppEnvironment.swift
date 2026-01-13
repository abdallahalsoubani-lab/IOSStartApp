import Foundation

/// Manages app-wide environment and configuration
struct AppEnvironment {
    // MARK: - Properties

    let flavor: String
    let environment: String
    let appName: String
    let appVersion: String
    let buildNumber: String
    let bundleIdentifier: String
    let apiBaseURL: String
    let isRelease: Bool
    let isDebugLoggingEnabled: Bool

    // MARK: - Initialization

    static let shared = AppEnvironment()

    init() {
        self.flavor = Self.readFromEnvironment("FLAVOR") ?? "YGB"
        self.environment = Self.readFromEnvironment("API_ENVIRONMENT") ?? "development"
        self.appName = Self.readFromEnvironment("APP_NAME") ?? "Enterprise iOS App"
        self.bundleIdentifier = Bundle.main.bundleIdentifier ?? "com.example.app"
        self.apiBaseURL = Self.readFromEnvironment("API_BASE_URL") ?? "https://api.example.com"

        #if DEBUG
        self.isDebugLoggingEnabled = true
        self.isRelease = false
        #else
        self.isDebugLoggingEnabled = false
        self.isRelease = true
        #endif

        self.appVersion = Bundle.main.appVersion
        self.buildNumber = Bundle.main.buildNumber
    }

    // MARK: - Methods

    private static func readFromEnvironment(_ key: String) -> String? {
        // Try to read from xcconfig
        ProcessInfo.processInfo.environment[key]
    }

    func logEnvironmentInfo() {
        #if DEBUG
        print("""
        ========== APP ENVIRONMENT ==========
        Flavor: \(flavor)
        Environment: \(environment)
        App Name: \(appName)
        Bundle ID: \(bundleIdentifier)
        API Base URL: \(apiBaseURL)
        Version: \(appVersion) (\(buildNumber))
        Debug Logging: \(isDebugLoggingEnabled)
        Release Mode: \(isRelease)
        ====================================
        """)
        #endif
    }
}

// MARK: - Constants

struct AppConstants {
    // Network
    static let networkTimeout: TimeInterval = 30
    static let retryCount = 3

    // Cache
    static let cacheExpiration: TimeInterval = 60 * 60 * 24 // 1 day

    // UI
    static let animationDuration: TimeInterval = 0.3
    static let debounceDelay: TimeInterval = 0.5

    // Storage
    static let userDefaultsPrefix = "app_"
}

// MARK: - Build Information

struct BuildInfo {
    static let appName = Bundle.main.appName
    static let appVersion = Bundle.main.appVersion
    static let buildNumber = Bundle.main.buildNumber
    static let bundleIdentifier = Bundle.main.bundleIdentifier ?? "unknown"
}
