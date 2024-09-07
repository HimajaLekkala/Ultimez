import SwiftUI

@main
struct UltimezSampleApp: App {
    var body: some Scene {
        WindowGroup {
            CoordinatorView()
        }
    }
}

struct CoordinatorView: View {
    @StateObject private var coordinator = AppCoordinator()
    
    var body: some View {
        NavigationStack(path: $coordinator.path) {
            coordinator.buildScreen(screen: .productList)
                .navigationDestination(for: Screen.self) { screen in
                    coordinator.buildScreen(screen: screen)
                }
        }
        .environmentObject(coordinator)
    }
}
