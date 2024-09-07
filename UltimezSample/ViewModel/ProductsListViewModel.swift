import Foundation
import Combine

class ProductsListViewModel: ObservableObject {
    @Published var products: ProductsListModel?
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    
    private var cancellables = Set<AnyCancellable>()
    private let productService: ProductListService
    
    init(productService: ProductListService) {
        self.productService = productService
        self.fetchProducts()
    }
    
    func fetchProducts() {
        isLoading = true
        errorMessage = nil
        
        self.productService.fetchProducts()
            .handleEvents(receiveCompletion: { [weak self] _ in
                self?.isLoading = false
            })
            .sink(receiveCompletion: { [weak self] completion in
                if case .failure(let error) = completion {
                    self?.errorMessage = error.localizedDescription
                }
            }, receiveValue: { [weak self] productList in
                self?.products = productList
            })
            .store(in: &cancellables)
    }
}
