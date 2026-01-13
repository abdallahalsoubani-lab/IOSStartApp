import SwiftUI

struct AppGuideView: View {
    @ObservedObject var navigator: Navigator
    @StateObject private var localizationManager = LocalizationManager.shared
    @Environment(\.appTheme) var theme
    @State private var selectedSection: Int = 0

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: theme.spacing.lg) {
                    // Header
                    VStack(alignment: .leading, spacing: theme.spacing.sm) {
                        Text("App Guide & Components Catalog")
                            .font(theme.typography.headlineLarge)
                            .foregroundColor(theme.colors.onBackground)

                        Text("Live documentation of design system and components")
                            .font(theme.typography.bodySmall)
                            .foregroundColor(theme.colors.onBackground.opacity(0.6))
                    }
                    .padding(theme.spacing.lg)
                    .background(theme.colors.surfaceVariant)
                    .cornerRadius(8)

                    // 1. Theme Preview
                    themePreviewSection

                    // 2. Button Styles
                    buttonStylesSection

                    // 3. TextField States
                    textFieldStatesSection

                    // 4. Loading/Empty/Error States
                    statesSection

                    // 5. Alerts
                    alertsSection

                    // 6. Localization
                    localizationSection

                    // 7. Router Demo
                    routerDemoSection

                    // 8. Firebase Status
                    firebaseStatusSection
                }
                .padding(theme.spacing.md)
            }
            .navigationTitle("App Guide")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        navigator.pop()
                    }) {
                        HStack(spacing: 4) {
                            Image(systemName: "chevron.left")
                            Text("Back")
                        }
                    }
                }
            }
        }
    }

    // MARK: - Sections

    @ViewBuilder
    private var themePreviewSection: some View {
        SectionView(title: "1. Theme Preview", icon: "paintpalette") {
            VStack(spacing: theme.spacing.md) {
                Text("Colors:")
                    .font(theme.typography.labelLarge)

                HStack(spacing: theme.spacing.sm) {
                    ColorBox(color: theme.colors.primary, label: "Primary")
                    ColorBox(color: theme.colors.secondary, label: "Secondary")
                    ColorBox(color: theme.colors.accent, label: "Accent")
                    ColorBox(color: theme.colors.error, label: "Error")
                }

                HStack(spacing: theme.spacing.sm) {
                    ColorBox(color: theme.colors.success, label: "Success")
                    ColorBox(color: theme.colors.warning, label: "Warning")
                    ColorBox(color: theme.colors.info, label: "Info")
                }

                Divider()

                Text("Typography:")
                    .font(theme.typography.labelLarge)

                VStack(alignment: .leading, spacing: theme.spacing.sm) {
                    Text("Display Large").font(theme.typography.displayLarge)
                    Text("Headline Large").font(theme.typography.headlineLarge)
                    Text("Title Large").font(theme.typography.titleLarge)
                    Text("Body Medium").font(theme.typography.bodyMedium)
                    Text("Label Small").font(theme.typography.labelSmall)
                }
            }
        }
    }

    @ViewBuilder
    private var buttonStylesSection: some View {
        SectionView(title: "2. AppButton Styles", icon: "rectangle.fill") {
            VStack(spacing: theme.spacing.md) {
                AppButton("Primary Button", style: .primary)
                AppButton("Secondary Button", style: .secondary)
                AppButton("Outlined Button", style: .outlined)
                AppButton("Ghost Button", style: .ghost)
                AppButton("Loading Button", state: .loading)
                AppButton("Disabled Button", state: .disabled)
            }
        }
    }

    @ViewBuilder
    private var textFieldStatesSection: some View {
        SectionView(title: "3. AppTextField States", icon: "textfield") {
            VStack(spacing: theme.spacing.md) {
                AppTextField(placeholder: "Normal state", text: .constant(""))
                AppTextField(placeholder: "Success state", text: .constant("valid"), state: .success)
                AppTextField(placeholder: "Error state", text: .constant(""), state: .error("Invalid input"))
                AppTextField(placeholder: "Loading state", text: .constant(""), state: .loading)
                AppTextField(placeholder: "Secure input", text: .constant(""), isSecure: true)
            }
        }
    }

    @ViewBuilder
    private var statesSection: some View {
        SectionView(title: "4. State Views", icon: "square.stack") {
            VStack(spacing: theme.spacing.md) {
                Text("Loading State:")
                    .font(theme.typography.labelLarge)
                LoadingView(message: "Loading data...")
                    .frame(height: 120)
                    .cornerRadius(8)
                    .border(theme.colors.divider)

                Divider()

                Text("Empty State:")
                    .font(theme.typography.labelLarge)
                EmptyStateView(
                    title: "No Items",
                    message: "You don't have any items yet",
                    icon: "inbox",
                    action: { print("Create tapped") },
                    actionTitle: "Create Item"
                )
                .frame(height: 200)
                .cornerRadius(8)
                .border(theme.colors.divider)

                Divider()

                Text("Error State:")
                    .font(theme.typography.labelLarge)
                ErrorStateView(
                    message: "Failed to load data",
                    errorDetails: "Network error: Connection timeout",
                    action: { print("Retry tapped") },
                    actionTitle: "Try Again"
                )
                .frame(height: 200)
                .cornerRadius(8)
                .border(theme.colors.divider)
            }
        }
    }

    @ViewBuilder
    private var alertsSection: some View {
        SectionView(title: "5. Alerts Demo", icon: "exclamationmark.bubble") {
            VStack(spacing: theme.spacing.md) {
                AppButton("Show System Alert") {
                    // System alert
                }
                AppButton("Show Custom Alert") {
                    navigator.presentSheet(AppRoute(path: .customAlert))
                }
            }
        }
    }

    @ViewBuilder
    private var localizationSection: some View {
        SectionView(title: "6. Localization", icon: "globe") {
            VStack(spacing: theme.spacing.md) {
                Text("Current Language: \(localizationManager.currentLanguage.displayName)")
                    .font(theme.typography.bodyMedium)

                Text("Text Direction: \(localizationManager.isRTL ? "RTL" : "LTR")")
                    .font(theme.typography.bodyMedium)

                HStack(spacing: theme.spacing.md) {
                    AppButton("English") {
                        localizationManager.setLanguage(.english)
                    }

                    AppButton("العربية") {
                        localizationManager.setLanguage(.arabic)
                    }
                }

                Text("Example text in current language")
                    .font(theme.typography.bodySmall)
                    .foregroundColor(theme.colors.onBackground.opacity(0.6))
                    .frame(maxWidth: .infinity)
                    .padding(theme.spacing.md)
                    .background(theme.colors.surfaceVariant)
                    .cornerRadius(8)
            }
        }
    }

    @ViewBuilder
    private var routerDemoSection: some View {
        SectionView(title: "7. Router Demo", icon: "arrow.triangle.branch") {
            VStack(spacing: theme.spacing.md) {
                Text("Available Routes:")
                    .font(theme.typography.labelLarge)

                routeButton("home", "Home")
                routeButton("app-guide", "App Guide")
            }
        }
    }

    @ViewBuilder
    private var firebaseStatusSection: some View {
        SectionView(title: "8. Firebase Messaging Status", icon: "bell.badge") {
            VStack(alignment: .leading, spacing: theme.spacing.md) {
                VStack(alignment: .leading, spacing: theme.spacing.xs) {
                    Text("Permission Status:")
                        .font(theme.typography.labelMedium)
                    Text("Authorized (Tap to check)")
                        .font(theme.typography.bodySmall)
                        .foregroundColor(theme.colors.onBackground.opacity(0.6))
                }

                VStack(alignment: .leading, spacing: theme.spacing.xs) {
                    Text("FCM Token:")
                        .font(theme.typography.labelMedium)
                    Text(fcmTokenPlaceholder)
                        .font(.system(size: 11, design: .monospaced))
                        .foregroundColor(theme.colors.onBackground.opacity(0.6))
                        .lineLimit(3)
                }
                .padding(theme.spacing.sm)
                .background(theme.colors.surfaceVariant)
                .cornerRadius(4)

                AppButton("Copy Token") {
                    UIPasteboard.general.string = fcmTokenPlaceholder
                }
            }
        }
    }

    @ViewBuilder
    private func routeButton(_ route: String, _ label: String) -> some View {
        Button(action: {
            if let appRoute = AppRoute(rawValue: route) {
                navigator.navigate(to: appRoute)
            }
        }) {
            HStack {
                Text(label)
                Spacer()
                Image(systemName: "chevron.right")
            }
            .foregroundColor(theme.colors.primary)
            .padding(theme.spacing.md)
            .background(theme.colors.surfaceVariant)
            .cornerRadius(8)
        }
    }

    private var fcmTokenPlaceholder: String {
        UserDefaults.standard.string(forKey: "fcm_token") ?? "fcm_placeholder_token_here"
    }
}

// MARK: - Helper Components

struct SectionView<Content: View>: View {
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
            HStack(spacing: theme.spacing.sm) {
                Image(systemName: icon)
                    .foregroundColor(theme.colors.primary)
                Text(title)
                    .font(theme.typography.titleSmall)
                    .foregroundColor(theme.colors.onBackground)
                Spacer()
            }

            content
                .padding(theme.spacing.md)
                .background(theme.colors.surface)
                .cornerRadius(8)
                .border(theme.colors.divider)
        }
        .padding(theme.spacing.md)
        .background(theme.colors.surfaceVariant)
        .cornerRadius(12)
    }
}

struct ColorBox: View {
    let color: Color
    let label: String
    @Environment(\.appTheme) var theme

    var body: some View {
        VStack(spacing: theme.spacing.xs) {
            color
                .frame(height: 60)
                .cornerRadius(4)

            Text(label)
                .font(theme.typography.labelSmall)
                .lineLimit(1)
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    AppGuideView(navigator: Navigator())
        .appTheme(AppTheme())
}
