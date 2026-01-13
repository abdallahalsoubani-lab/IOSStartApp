import SwiftUI

struct LoadingView: View {
    let message: String
    @Environment(\.appTheme) var theme

    var body: some View {
        VStack(spacing: theme.spacing.lg) {
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: theme.colors.primary))
                .scaleEffect(1.5)

            Text(message)
                .font(theme.typography.bodyMedium)
                .foregroundColor(theme.colors.onBackground.opacity(0.7))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(theme.colors.background)
    }
}

struct EmptyStateView: View {
    let title: String
    let message: String
    let icon: String
    let action: (() -> Void)?
    let actionTitle: String?
    @Environment(\.appTheme) var theme

    init(
        title: String,
        message: String,
        icon: String = "folder",
        action: (() -> Void)? = nil,
        actionTitle: String? = nil
    ) {
        self.title = title
        self.message = message
        self.icon = icon
        self.action = action
        self.actionTitle = actionTitle
    }

    var body: some View {
        VStack(spacing: theme.spacing.lg) {
            Image(systemName: icon)
                .font(.system(size: 60))
                .foregroundColor(theme.colors.primary.opacity(0.5))

            Text(title)
                .font(theme.typography.headlineSmall)
                .foregroundColor(theme.colors.onBackground)

            Text(message)
                .font(theme.typography.bodyMedium)
                .foregroundColor(theme.colors.onBackground.opacity(0.6))
                .multilineTextAlignment(.center)

            if let action = action, let actionTitle = actionTitle {
                Button(action: action) {
                    Text(actionTitle)
                        .frame(maxWidth: .infinity)
                        .padding(theme.spacing.md)
                        .background(theme.colors.primary)
                        .foregroundColor(theme.colors.onPrimary)
                        .cornerRadius(8)
                }
            }

            Spacer()
        }
        .padding(theme.spacing.lg)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(theme.colors.background)
    }
}

struct ErrorStateView: View {
    let title: String
    let message: String
    let errorDetails: String?
    let action: (() -> Void)?
    let actionTitle: String?
    @Environment(\.appTheme) var theme

    init(
        title: String = "Error",
        message: String,
        errorDetails: String? = nil,
        action: (() -> Void)? = nil,
        actionTitle: String? = nil
    ) {
        self.title = title
        self.message = message
        self.errorDetails = errorDetails
        self.action = action
        self.actionTitle = actionTitle
    }

    var body: some View {
        VStack(spacing: theme.spacing.lg) {
            Image(systemName: "exclamationmark.triangle.fill")
                .font(.system(size: 60))
                .foregroundColor(theme.colors.error)

            Text(title)
                .font(theme.typography.headlineSmall)
                .foregroundColor(theme.colors.onBackground)

            Text(message)
                .font(theme.typography.bodyMedium)
                .foregroundColor(theme.colors.onBackground.opacity(0.6))
                .multilineTextAlignment(.center)

            if let errorDetails = errorDetails {
                VStack(alignment: .leading, spacing: theme.spacing.xs) {
                    Text("Details:")
                        .font(theme.typography.labelSmall)
                        .foregroundColor(theme.colors.error)

                    Text(errorDetails)
                        .font(theme.typography.bodySmall)
                        .foregroundColor(theme.colors.error.opacity(0.7))
                        .lineLimit(3)
                }
                .padding(theme.spacing.md)
                .background(theme.colors.error.opacity(0.1))
                .cornerRadius(8)
            }

            if let action = action, let actionTitle = actionTitle {
                Button(action: action) {
                    Text(actionTitle)
                        .frame(maxWidth: .infinity)
                        .padding(theme.spacing.md)
                        .background(theme.colors.error)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }

            Spacer()
        }
        .padding(theme.spacing.lg)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(theme.colors.background)
    }
}

#Preview {
    VStack {
        LoadingView(message: "Loading data...")
    }
    .appTheme(AppTheme())
}

#Preview {
    VStack {
        EmptyStateView(
            title: "No Items",
            message: "You don't have any items yet",
            icon: "inbox",
            action: {},
            actionTitle: "Create Item"
        )
    }
    .appTheme(AppTheme())
}

#Preview {
    VStack {
        ErrorStateView(
            message: "Failed to load data",
            errorDetails: "Network error: Connection timeout",
            action: {},
            actionTitle: "Try Again"
        )
    }
    .appTheme(AppTheme())
}
