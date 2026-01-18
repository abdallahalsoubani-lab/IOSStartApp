import SwiftUI

struct AppTheme {
    let colors: ColorTokens
    let typography: TypographyTokens
    let spacing: SpacingTokens
    let shadows: ShadowTokens

    init(
        colors: ColorTokens = .default,
        typography: TypographyTokens = .default,
        spacing: SpacingTokens = .default,
        shadows: ShadowTokens = .default
    ) {
        self.colors = colors
        self.typography = typography
        self.spacing = spacing
        self.shadows = shadows
    }
}

// MARK: - Color Tokens

struct ColorTokens {
    let primary: Color
    let secondary: Color
    let accent: Color
    let background: Color
    let surface: Color
    let surfaceVariant: Color
    let onPrimary: Color
    let onSecondary: Color
    let onBackground: Color
    let onSurface: Color
    let error: Color
    let success: Color
    let warning: Color
    let info: Color
    let divider: Color

    static let `default` = ColorTokens(
        primary: Color(red: 0.2, green: 0.4, blue: 0.8),
        secondary: Color(red: 0.8, green: 0.4, blue: 0.2),
        accent: Color(red: 1.0, green: 0.6, blue: 0.0),
        background: Color(red: 0.98, green: 0.98, blue: 0.98),
        surface: Color.white,
        surfaceVariant: Color(red: 0.95, green: 0.95, blue: 0.95),
        onPrimary: Color.white,
        onSecondary: Color.white,
        onBackground: Color(red: 0.1, green: 0.1, blue: 0.1),
        onSurface: Color(red: 0.2, green: 0.2, blue: 0.2),
        error: Color(red: 0.9, green: 0.2, blue: 0.2),
        success: Color(red: 0.2, green: 0.8, blue: 0.2),
        warning: Color(red: 1.0, green: 0.7, blue: 0.0),
        info: Color(red: 0.2, green: 0.7, blue: 0.9),
        divider: Color(red: 0.85, green: 0.85, blue: 0.85)
    )
}

// MARK: - Typography Tokens

struct TypographyTokens {
    let displayLarge: Font
    let displayMedium: Font
    let displaySmall: Font
    let headlineLarge: Font
    let headlineMedium: Font
    let headlineSmall: Font
    let titleLarge: Font
    let titleMedium: Font
    let titleSmall: Font
    let bodyLarge: Font
    let bodyMedium: Font
    let bodySmall: Font
    let labelLarge: Font
    let labelMedium: Font
    let labelSmall: Font

    static let `default` = TypographyTokens(
        displayLarge: .system(size: 57, weight: .bold),
        displayMedium: .system(size: 45, weight: .bold),
        displaySmall: .system(size: 36, weight: .bold),
        headlineLarge: .system(size: 32, weight: .bold),
        headlineMedium: .system(size: 28, weight: .bold),
        headlineSmall: .system(size: 24, weight: .bold),
        titleLarge: .system(size: 22, weight: .semibold),
        titleMedium: .system(size: 18, weight: .semibold),
        titleSmall: .system(size: 16, weight: .semibold),
        bodyLarge: .system(size: 16, weight: .regular),
        bodyMedium: .system(size: 14, weight: .regular),
        bodySmall: .system(size: 12, weight: .regular),
        labelLarge: .system(size: 14, weight: .medium),
        labelMedium: .system(size: 12, weight: .medium),
        labelSmall: .system(size: 11, weight: .medium)
    )
}

// MARK: - Spacing Tokens

struct SpacingTokens {
    let xs: CGFloat
    let sm: CGFloat
    let md: CGFloat
    let lg: CGFloat
    let xl: CGFloat
    let xxl: CGFloat

    static let `default` = SpacingTokens(
        xs: 4,
        sm: 8,
        md: 16,
        lg: 24,
        xl: 32,
        xxl: 48
    )
}

// MARK: - Shadow Tokens

struct ShadowTokens {
    let elevation0: Shadow
    let elevation1: Shadow
    let elevation2: Shadow
    let elevation3: Shadow

    struct Shadow {
        let color: Color
        let radius: CGFloat
        let offsetX: CGFloat
        let offsetY: CGFloat
        let opacity: Double
    }

    static let `default` = ShadowTokens(
        elevation0: Shadow(color: .black, radius: 0, offsetX: 0, offsetY: 0, opacity: 0),
        elevation1: Shadow(color: .black, radius: 4, offsetX: 0, offsetY: 1, opacity: 0.1),
        elevation2: Shadow(color: .black, radius: 8, offsetX: 0, offsetY: 2, opacity: 0.12),
        elevation3: Shadow(color: .black, radius: 12, offsetX: 0, offsetY: 4, opacity: 0.15)
    )
}

// MARK: - Environment Key

struct AppThemeKey: EnvironmentKey {
    static let defaultValue = AppTheme()
}

extension EnvironmentValues {
    var appTheme: AppTheme {
        get { self[AppThemeKey.self] }
        set { self[AppThemeKey.self] = newValue }
    }
}

// MARK: - View Extension

extension View {
    func appTheme(_ theme: AppTheme) -> some View {
        environment(\.appTheme, theme)
    }
}
