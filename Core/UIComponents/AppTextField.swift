import SwiftUI

struct AppTextField: View {
    enum State: Equatable {
        case normal
        case error(String)
        case success
        case loading
    }

    let placeholder: String
    @Binding var text: String
    let state: State
    let isSecure: Bool
    let onEditingChanged: (Bool) -> Void
    @Environment(\.appTheme) var theme

    init(
        placeholder: String,
        text: Binding<String>,
        state: State = .normal,
        isSecure: Bool = false,
        onEditingChanged: @escaping (Bool) -> Void = { _ in }
    ) {
        self.placeholder = placeholder
        self._text = text
        self.state = state
        self.isSecure = isSecure
        self.onEditingChanged = onEditingChanged
    }

    var body: some View {
        VStack(alignment: .leading, spacing: theme.spacing.xs) {
            HStack(spacing: theme.spacing.sm) {
                if isSecure {
                    SecureField(placeholder, text: $text)
                        .textFieldStyle(.roundedBorder)
                        .padding(theme.spacing.sm)
                        .background(theme.colors.surface)
                        .cornerRadius(8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(borderColor, lineWidth: 1)
                        )
                } else {
                    TextField(placeholder, text: $text)
                        .textFieldStyle(.roundedBorder)
                        .padding(theme.spacing.sm)
                        .background(theme.colors.surface)
                        .cornerRadius(8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(borderColor, lineWidth: 1)
                        )
                }

                if state == .loading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: theme.colors.primary))
                        .frame(width: 20, height: 20)
                        .padding(.trailing, theme.spacing.sm)
                } else if state == .success {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(theme.colors.success)
                        .padding(.trailing, theme.spacing.sm)
                } else if case .error = state {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(theme.colors.error)
                        .padding(.trailing, theme.spacing.sm)
                }
            }

            if case let .error(message) = state {
                Text(message)
                    .font(theme.typography.labelSmall)
                    .foregroundColor(theme.colors.error)
                    .padding(.leading, theme.spacing.sm)
            }
        }
    }

    private var borderColor: Color {
        switch state {
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

#Preview {
    VStack(spacing: 16) {
        AppTextField(placeholder: "Normal", text: .constant(""))
        AppTextField(placeholder: "Error", text: .constant("test"), state: .error("Invalid input"))
        AppTextField(placeholder: "Success", text: .constant("valid"), state: .success)
        AppTextField(placeholder: "Loading", text: .constant(""), state: .loading)
        AppTextField(placeholder: "Secure", text: .constant(""), isSecure: true)
    }
    .padding()
    .appTheme(AppTheme())
}
