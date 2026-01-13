import SwiftUI

struct AppButton: View {
    enum Style {
        case primary
        case secondary
        case outlined
        case ghost
    }

    enum State {
        case normal
        case loading
        case disabled
    }

    let title: String
    let style: Style
    let state: State
    let action: () -> Void
    @Environment(\.appTheme) var theme

    init(
        _ title: String,
        style: Style = .primary,
        state: State = .normal,
        action: @escaping () -> Void = {}
    ) {
        self.title = title
        self.style = style
        self.state = state
        self.action = action
    }

    var body: some View {
        Button(action: {
            if state == .normal {
                action()
            }
        }) {
            HStack(spacing: theme.spacing.sm) {
                if state == .loading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: foregroundColor))
                        .frame(height: 20)
                }

                Text(title)
                    .font(theme.typography.labelLarge)
                    .fontWeight(.semibold)
            }
            .frame(maxWidth: .infinity)
            .padding(theme.spacing.md)
            .background(backgroundColor)
            .foregroundColor(foregroundColor)
            .cornerRadius(8)
            .border(borderColor, width: borderWidth)
            .opacity(state == .disabled ? 0.5 : 1.0)
        }
        .disabled(state != .normal)
    }

    private var backgroundColor: Color {
        switch (style, state) {
        case (.primary, _):
            return theme.colors.primary
        case (.secondary, _):
            return theme.colors.secondary
        case (.outlined, _):
            return Color.clear
        case (.ghost, _):
            return Color.clear
        }
    }

    private var foregroundColor: Color {
        switch style {
        case .primary:
            return theme.colors.onPrimary
        case .secondary:
            return theme.colors.onSecondary
        case .outlined:
            return theme.colors.primary
        case .ghost:
            return theme.colors.primary
        }
    }

    private var borderColor: Color {
        switch style {
        case .outlined:
            return theme.colors.primary
        default:
            return Color.clear
        }
    }

    private var borderWidth: CGFloat {
        style == .outlined ? 1 : 0
    }
}

#Preview {
    VStack(spacing: 16) {
        AppButton("Primary Button")
        AppButton("Secondary Button", style: .secondary)
        AppButton("Outlined Button", style: .outlined)
        AppButton("Ghost Button", style: .ghost)
        AppButton("Loading Button", state: .loading)
        AppButton("Disabled Button", state: .disabled)
    }
    .padding()
    .appTheme(AppTheme())
}
