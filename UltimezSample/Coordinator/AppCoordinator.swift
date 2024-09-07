import Foundation
import SwiftUI

enum Screen: String, Identifiable {
    case productList
    case productDetail
    
    var id: String {
        return self.rawValue
    }
}

class AppCoordinator: ObservableObject {
    @Published var path = NavigationPath()
    
    func push(screen: Screen) {
        self.path.append(screen)
    }
    
    func pop() {
        self.path.removeLast()
    }
    
    @ViewBuilder
    func buildScreen(screen: Screen) -> some View {
        switch screen {
        case .productList:
            ProductListView()
        case .productDetail:
            ProductDetailView()
        }
    }
}
