import SwiftUI

class CustomAlertNavigation: AppNavigation {
    func registerRoutes(_ navigator: Navigator) {
        navigator.registerRoute("custom-alert") { navigator in
            AnyView(CustomAlertView(navigator: navigator))
        }
    }
}

struct CustomAlertView: View {
    @ObservedObject var navigator: Navigator
    @Environment(\.appTheme) var theme

    var body: some View {
        VStack(spacing: theme.spacing.lg) {
            Text("Custom Alert")
                .font(theme.typography.headlineMedium)
                .foregroundColor(theme.colors.onBackground)

            Text("This is a custom alert/modal screen")
                .font(theme.typography.bodyMedium)
                .foregroundColor(theme.colors.onBackground.opacity(0.7))

            VStack(spacing: theme.spacing.md) {
                Button(action: {
                    navigator.dismissSheet()
                }) {
                    Text("Close Alert")
                        .frame(maxWidth: .infinity)
                        .padding(theme.spacing.md)
                        .background(theme.colors.primary)
                        .foregroundColor(theme.colors.onPrimary)
                        .cornerRadius(8)
                }
            }
            .padding(theme.spacing.md)

            Spacer()
        }
        .padding(theme.spacing.lg)
        .background(theme.colors.surface)
    }
}

#Preview {
    CustomAlertView(navigator: Navigator())
        .appTheme(AppTheme())
}
