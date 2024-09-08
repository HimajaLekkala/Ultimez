import Foundation
import SwiftUI

enum Screen: Identifiable, Hashable {
    case productList
    case productDetail(product: ProductsListResultModel)
    
    var id: String {
        switch self {
        case .productDetail(_):
            return "productDetail"
        case .productList:
            return "productList"
        }
    }
}

class AppCoordinator: ObservableObject {
    @Published var path = NavigationPath()
    var networkManager = NetworkManager()
    
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
            ProductListView(viewModel: ProductsListViewModel(productService: ProductListService(networkService: self.networkManager)))
        case .productDetail(let product):
            ProductDetailView(product: product)
        }
    }
}
