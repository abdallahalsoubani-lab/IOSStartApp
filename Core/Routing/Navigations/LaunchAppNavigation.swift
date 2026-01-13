import SwiftUI

class LaunchAppNavigation: AppNavigation {
    func registerRoutes(_ navigator: Navigator) {
        navigator.registerRoute("launch") { navigator in
            AnyView(LaunchScreenView(navigator: navigator))
        }
    }
}

struct LaunchScreenView: View {
    @ObservedObject var navigator: Navigator

    var body: some View {
        ZStack {
            Color.blue.ignoresSafeArea()

            VStack(spacing: 20) {
                Image(systemName: "iphone.gen3")
                    .font(.system(size: 80))
                    .foregroundColor(.white)

                Text("Enterprise iOS App")
                    .font(.title)
                    .foregroundColor(.white)

                Text("Loading...")
                    .font(.body)
                    .foregroundColor(.white.opacity(0.7))

                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                navigator.navigate(to: AppRoute(path: .home))
            }
        }
    }
}

#Preview {
    LaunchScreenView(navigator: Navigator())
}
