import SwiftUI
import Kingfisher

struct ProductListView: View {
    @StateObject var viewModel: ProductsListViewModel
    
    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView("Loading...")
            } else if let errorMessage = viewModel.errorMessage {
                Text("Error: \(errorMessage)")
            } else if let products = viewModel.products {
                ProductGridView(products: products)
            } else {
                Text("No products available")
            }
        }
        .background(Color(.systemBackground))
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
    
    var body: some View {
        VStack(spacing: 16) {
            KFImage(URL(string: product.imageURLs.first ?? ""))
                .placeholder {
                    ProgressView()
                        .frame(height: 230)
                }
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 230)
                .clipped()
            
            Text(product.name)
                .foregroundColor(.primary)
            
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
    }
}

#Preview {
    ProductListView(viewModel: ProductsListViewModel(productService: ProductListService(networkService: NetworkManager())))
}
