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
    @StateObject private var localizationManager = LocalizationManager.shared
    @Environment(\.appTheme) var theme
    
    @State private var notificationsEnabled: Bool = true
    @State private var darkModeEnabled: Bool = false
    @State private var selectedLanguage: String = "English"
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: theme.spacing.lg) {
                // Header
                VStack(alignment: .leading, spacing: theme.spacing.sm) {
                    Text("Settings")
                        .font(theme.typography.displayMedium)
                        .foregroundColor(theme.colors.onBackground)
                    
                    Text("Manage your app preferences")
                        .font(theme.typography.bodyMedium)
                        .foregroundColor(theme.colors.onBackground.opacity(0.6))
                }
                .padding(theme.spacing.lg)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(theme.colors.surfaceVariant)
                .cornerRadius(12)
                
                // Notifications Section
                SettingsSectionView(title: "Notifications", icon: "bell.fill") {
                    SettingsToggleRow(
                        title: "Push Notifications",
                        description: "Receive notifications about updates",
                        isOn: $notificationsEnabled
                    )
                }
                
                // Appearance Section
                SettingsSectionView(title: "Appearance", icon: "paintbrush.fill") {
                    SettingsToggleRow(
                        title: "Dark Mode",
                        description: "Enable dark theme",
                        isOn: $darkModeEnabled
                    )
                }
                
                // Language Section
                SettingsSectionView(title: "Language", icon: "globe") {
                    VStack(spacing: theme.spacing.md) {
                        LanguageButton(
                            title: "English",
                            isSelected: localizationManager.currentLanguage == .english
                        ) {
                            localizationManager.setLanguage(.english)
                        }
                        
                        LanguageButton(
                            title: "العربية",
                            isSelected: localizationManager.currentLanguage == .arabic
                        ) {
                            localizationManager.setLanguage(.arabic)
                        }
                    }
                }
                
                // Account Section
                SettingsSectionView(title: "Account", icon: "person.fill") {
                    VStack(spacing: theme.spacing.sm) {
                        SettingsActionRow(
                            title: "Edit Profile",
                            icon: "pencil"
                        ) {
                            print("Edit Profile tapped")
                        }
                        
                        Divider()
                        
                        SettingsActionRow(
                            title: "Change Password",
                            icon: "lock"
                        ) {
                            print("Change Password tapped")
                        }
                        
                        Divider()
                        
                        SettingsActionRow(
                            title: "Logout",
                            icon: "rectangle.portrait.and.arrow.right",
                            isDestructive: true
                        ) {
                            navigator.popToRoot()
                        }
                    }
                }
                
                // About Section
                SettingsSectionView(title: "About", icon: "info.circle.fill") {
                    VStack(alignment: .leading, spacing: theme.spacing.sm) {
                        HStack {
                            Text("Version")
                                .font(theme.typography.bodyMedium)
                                .foregroundColor(theme.colors.onBackground)
                            Spacer()
                            Text("1.0.0")
                                .font(theme.typography.bodyMedium)
                                .foregroundColor(theme.colors.onBackground.opacity(0.6))
                        }
                        
                        Divider()
                        
                        HStack {
                            Text("Build")
                                .font(theme.typography.bodyMedium)
                                .foregroundColor(theme.colors.onBackground)
                            Spacer()
                            Text("100")
                                .font(theme.typography.bodyMedium)
                                .foregroundColor(theme.colors.onBackground.opacity(0.6))
                        }
                    }
                }
                
                // Back Button
                Button(action: {
                    navigator.pop()
                }) {
                    HStack {
                        Image(systemName: "chevron.left")
                        Text("Back to Home")
                    }
                    .frame(maxWidth: .infinity)
                    .padding(theme.spacing.md)
                    .background(theme.colors.surfaceVariant)
                    .foregroundColor(theme.colors.onSurface)
                    .cornerRadius(12)
                }
            }
            .padding(theme.spacing.lg)
        }
        .background(theme.colors.background)
    }
}

// MARK: - Components

struct SettingsSectionView<Content: View>: View {
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
                    .font(.system(size: 16, weight: .semibold))
                
                Text(title)
                    .font(theme.typography.titleMedium)
                    .foregroundColor(theme.colors.onBackground)
            }
            
            VStack(spacing: theme.spacing.sm) {
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

struct SettingsToggleRow: View {
    let title: String
    let description: String
    @Binding var isOn: Bool
    @Environment(\.appTheme) var theme
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: theme.spacing.xs) {
                Text(title)
                    .font(theme.typography.bodyLarge)
                    .foregroundColor(theme.colors.onSurface)
                
                Text(description)
                    .font(theme.typography.bodySmall)
                    .foregroundColor(theme.colors.onSurface.opacity(0.6))
            }
            
            Spacer()
            
            Toggle("", isOn: $isOn)
                .labelsHidden()
                .tint(theme.colors.primary)
        }
    }
}

struct SettingsActionRow: View {
    let title: String
    let icon: String
    var isDestructive: Bool = false
    let action: () -> Void
    @Environment(\.appTheme) var theme
    
    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: icon)
                    .foregroundColor(isDestructive ? theme.colors.error : theme.colors.primary)
                    .font(.system(size: 16))
                    .frame(width: 24)
                
                Text(title)
                    .font(theme.typography.bodyMedium)
                    .foregroundColor(isDestructive ? theme.colors.error : theme.colors.onSurface)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .font(.system(size: 12))
                    .foregroundColor(theme.colors.onSurface.opacity(0.3))
            }
        }
    }
}

struct LanguageButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    @Environment(\.appTheme) var theme
    
    var body: some View {
        Button(action: action) {
            HStack {
                Text(title)
                    .font(theme.typography.bodyMedium)
                    .foregroundColor(isSelected ? theme.colors.onPrimary : theme.colors.onSurface)
                
                Spacer()
                
                if isSelected {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(theme.colors.onPrimary)
                }
            }
            .padding(theme.spacing.md)
            .background(isSelected ? theme.colors.primary : theme.colors.surfaceVariant)
            .cornerRadius(8)
        }
    }
}

#Preview {
    SettingsView(navigator: Navigator())
        .appTheme(AppTheme())
}
