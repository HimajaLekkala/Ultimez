import SwiftUI
import Kingfisher

struct ProductListView: View {
    @StateObject var viewModel: ProductsListViewModel
    
    var body: some View {
        VStack {
            stateView
        }
        .background(Color(.systemBackground))
    }
    
    @ViewBuilder
    private var stateView: some View {
        if viewModel.isLoading {
            ProgressView("Loading...")
        } else if let errorMessage = viewModel.errorMessage {
            ErrorView(message: errorMessage)
        } else if let products = viewModel.products {
            ProductGridView(products: products)
        } else {
            NoProductsView()
        }
    }
}

struct ErrorView: View {
    let message: String
    
    var body: some View {
        Text("Error: \(message)")
            .foregroundColor(.red)
            .padding()
    }
}

struct NoProductsView: View {
    var body: some View {
        Text("No products available")
            .foregroundColor(.secondary)
            .padding()
    }
}

struct ProductGridView: View {
    let products: ProductsListModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Products")
                .font(.title)
                .bold()
            
            ScrollView {
                LazyVGrid(columns: [
                    GridItem(.flexible()),
                    GridItem(.flexible())
                ], spacing: 16) {
                    ForEach(products.results, id: \.self) { product in
                        ProductRow(product: product)
                    }
                }
            }
            .scrollIndicators(.hidden)
        }
        .padding(EdgeInsets(top: 16, leading: 16, bottom: 0, trailing: 16))
    }
}

struct ProductRow: View {
    let product: ProductsListResultModel
    @EnvironmentObject var coordinator: AppCoordinator
    
    var body: some View {
        VStack(spacing: 16) {
            productImage
            productName
            Spacer()
        }
        .frame(width: (UIScreen.main.bounds.width - 48) / 2, height: 280)
        .background(Color(.systemBackground))
        .cornerRadius(8)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.primary.opacity(0.1), lineWidth: 1)
        )
        .shadow(color: Color.primary.opacity(0.1), radius: 6, x: 0, y: 4)
        .onTapGesture {
            coordinator.push(screen: .productDetail(product: product))
        }
    }
    
    private var productImage: some View {
        KFImage(URL(string: product.imageURLs.first ?? ""))
            .placeholder {
                ProgressView()
                    .frame(height: 230)
            }
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(height: 230)
            .clipped()
    }
    
    private var productName: some View {
        Text(product.name)
            .foregroundColor(.primary)
    }
}

#Preview {
    ProductListView(viewModel: ProductsListViewModel(productService: ProductListService(networkService: NetworkManager())))
}
