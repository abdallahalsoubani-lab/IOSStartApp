import SwiftUI

class AuthenticationAppNavigation: AppNavigation {
    func registerRoutes(_ navigator: Navigator) {
        navigator.registerRoute("login") { navigator in
            AnyView(LoginView(navigator: navigator))
        }
    }
}

struct LoginView: View {
    @ObservedObject var navigator: Navigator
    @State private var email = ""
    @State private var password = ""
    @State private var isLoading = false
    @State private var emailState: AppTextField.State = .normal
    @State private var passwordState: AppTextField.State = .normal
    @Environment(\.appTheme) var theme

    var body: some View {
        NavigationStack {
            VStack(spacing: theme.spacing.lg) {
                // Header
                VStack(spacing: theme.spacing.sm) {
                    Image(systemName: "lock.fill")
                        .font(.system(size: 60))
                        .foregroundColor(theme.colors.primary)

                    Text("Login")
                        .font(theme.typography.headlineLarge)
                        .foregroundColor(theme.colors.onBackground)

                    Text("Enter your credentials to continue")
                        .font(theme.typography.bodySmall)
                        .foregroundColor(theme.colors.onBackground.opacity(0.6))
                }
                .padding(theme.spacing.lg)

                // Form
                VStack(spacing: theme.spacing.lg) {
                    AppTextField(
                        placeholder: "Email",
                        text: $email,
                        state: emailState,
                        onEditingChanged: { _ in
                            validateEmail()
                        }
                    )

                    AppTextField(
                        placeholder: "Password",
                        text: $password,
                        state: passwordState,
                        isSecure: true
                    )

                    AppButton(
                        "Login",
                        state: isLoading ? .loading : .normal,
                        action: handleLogin
                    )
                }
                .padding(theme.spacing.lg)

                // Footer
                VStack(spacing: theme.spacing.md) {
                    Button(action: {
                        print("Forgot password tapped")
                    }) {
                        Text("Forgot Password?")
                            .font(theme.typography.bodySmall)
                            .foregroundColor(theme.colors.primary)
                    }

                    HStack(spacing: theme.spacing.sm) {
                        Text("Don't have an account?")
                            .font(theme.typography.bodySmall)
                            .foregroundColor(theme.colors.onBackground)

                        Button(action: {
                            print("Sign up tapped")
                        }) {
                            Text("Sign Up")
                                .font(theme.typography.bodySmall)
                                .fontWeight(.semibold)
                                .foregroundColor(theme.colors.primary)
                        }
                    }
                }
                .padding(theme.spacing.lg)

                Spacer()
            }
            .navigationTitle("Login")
        }
    }

    private func validateEmail() {
        if email.isBlank {
            emailState = .error("Email is required")
        } else if !email.isValidEmail {
            emailState = .error("Invalid email format")
        } else {
            emailState = .success
        }
    }

    private func handleLogin() {
        validateEmail()

        if password.count < 8 {
            passwordState = .error("Password must be at least 8 characters")
            return
        }

        isLoading = true

        // Simulate API call
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            isLoading = false
            navigator.navigate(to: AppRoute(path: .home))
        }
    }
}

#Preview {
    LoginView(navigator: Navigator())
        .appTheme(AppTheme())
}
