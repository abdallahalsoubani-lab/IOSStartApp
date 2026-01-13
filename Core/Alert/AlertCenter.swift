import UIKit
import Combine

class AlertCenter: ObservableObject {
    static let shared = AlertCenter()

    @Published var alert: Alert?

    enum AlertType {
        case success
        case error
        case warning
        case info
    }

    struct Alert: Identifiable {
        let id = UUID()
        let title: String?
        let message: String
        let type: AlertType
        let actions: [AlertAction]
        let dismissAfter: TimeInterval?

        init(
            title: String? = nil,
            message: String,
            type: AlertType = .info,
            actions: [AlertAction] = [],
            dismissAfter: TimeInterval? = nil
        ) {
            self.title = title
            self.message = message
            self.type = type
            self.actions = actions.isEmpty ? [AlertAction(title: "OK")] : actions
            self.dismissAfter = dismissAfter
        }
    }

    struct AlertAction {
        let title: String
        let style: UIAlertAction.Style
        let handler: (() -> Void)?

        init(
            title: String,
            style: UIAlertAction.Style = .default,
            handler: (() -> Void)? = nil
        ) {
            self.title = title
            self.style = style
            self.handler = handler
        }
    }

    func show(
        title: String? = nil,
        message: String,
        type: AlertType = .info,
        actions: [AlertAction] = []
    ) {
        let alert = Alert(
            title: title,
            message: message,
            type: type,
            actions: actions
        )
        self.alert = alert

        if let dismissAfter = alert.dismissAfter {
            DispatchQueue.main.asyncAfter(deadline: .now() + dismissAfter) {
                self.dismiss()
            }
        }
    }

    func showSuccess(message: String, title: String? = "Success") {
        show(title: title, message: message, type: .success, actions: [
            AlertAction(title: "OK") { self.dismiss() }
        ])
    }

    func showError(message: String, title: String? = "Error") {
        show(title: title, message: message, type: .error, actions: [
            AlertAction(title: "OK") { self.dismiss() }
        ])
    }

    func showWarning(message: String, title: String? = "Warning") {
        show(title: title, message: message, type: .warning, actions: [
            AlertAction(title: "OK") { self.dismiss() }
        ])
    }

    func confirm(
        title: String? = nil,
        message: String,
        onConfirm: @escaping () -> Void,
        onCancel: (() -> Void)? = nil
    ) {
        let actions = [
            AlertAction(title: "Cancel", style: .cancel) {
                self.dismiss()
                onCancel?()
            },
            AlertAction(title: "Confirm", style: .default) {
                self.dismiss()
                onConfirm()
            }
        ]

        show(title: title, message: message, type: .info, actions: actions)
    }

    func dismiss() {
        alert = nil
    }
}

// MARK: - AlertView for SwiftUI

struct AlertView: View {
    @ObservedObject var alertCenter: AlertCenter
    @Environment(\.appTheme) var theme

    var body: some View {
        if let alert = alertCenter.alert {
            ZStack {
                Color.black.opacity(0.3)
                    .ignoresSafeArea()
                    .onTapGesture {
                        alertCenter.dismiss()
                    }

                VStack(spacing: theme.spacing.md) {
                    if let title = alert.title {
                        Text(title)
                            .font(theme.typography.titleLarge)
                            .foregroundColor(theme.colors.onBackground)
                    }

                    Text(alert.message)
                        .font(theme.typography.bodyMedium)
                        .foregroundColor(theme.colors.onBackground.opacity(0.7))
                        .multilineTextAlignment(.center)

                    HStack(spacing: theme.spacing.md) {
                        ForEach(alert.actions.indices, id: \.self) { index in
                            let action = alert.actions[index]
                            Button(action: {
                                action.handler?()
                                if action.style != .cancel {
                                    alertCenter.dismiss()
                                }
                            }) {
                                Text(action.title)
                                    .frame(maxWidth: .infinity)
                                    .padding(theme.spacing.md)
                                    .background(actionButtonColor(for: action.style))
                                    .foregroundColor(actionButtonForeground(for: action.style))
                                    .cornerRadius(8)
                            }
                        }
                    }
                }
                .padding(theme.spacing.lg)
                .background(theme.colors.surface)
                .cornerRadius(16)
                .padding(theme.spacing.lg)
                .shadow(
                    color: theme.colors.onBackground.opacity(0.3),
                    radius: 8,
                    x: 0,
                    y: 2
                )
            }
            .transition(.opacity)
        }
    }

    private func actionButtonColor(for style: UIAlertAction.Style) -> Color {
        switch style {
        case .default:
            return theme.colors.primary
        case .cancel:
            return theme.colors.surfaceVariant
        case .destructive:
            return theme.colors.error
        @unknown default:
            return theme.colors.primary
        }
    }

    private func actionButtonForeground(for style: UIAlertAction.Style) -> Color {
        switch style {
        case .default:
            return theme.colors.onPrimary
        case .cancel:
            return theme.colors.onSurface
        case .destructive:
            return .white
        @unknown default:
            return theme.colors.onPrimary
        }
    }
}
