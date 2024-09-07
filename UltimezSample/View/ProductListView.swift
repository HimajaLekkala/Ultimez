import SwiftUI

struct ProductListView: View {
    @StateObject var viewModel: ProductsListViewModel
    
    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView("Loading...")
            } else if let errorMessage = viewModel.errorMessage {
                Text("Error: \(errorMessage)")
            } else if let products = viewModel.products {
                List(products.results, id: \.self) { product in
                    ProductRow(product: product)
                }
            } else {
                Text("No products available")
            }
        }
    }
}

struct ProductRow: View {
    let product: ProductsListResultModel

    var body: some View {
        HStack {
            Text(product.name)
            Spacer()
            Text("")
        }
        .padding()
    }
}

#Preview {
    ProductListView(viewModel: ProductsListViewModel(productService: ProductListService(networkService: NetworkManager())))
}
