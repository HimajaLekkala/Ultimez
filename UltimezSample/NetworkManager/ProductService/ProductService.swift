import Foundation
import Combine

protocol ProductService {
    func fetchProducts() -> AnyPublisher<ProductsListModel, NetworkError>
}

struct ProductListServiceRequest: APIRequest {
    typealias Response = ProductsListModel
    var url: String = "https://ey3f2y0nre.execute-api.us-east-1.amazonaws.com/default/dynamodb-writer"
    var method: HTTPMethod = .get
    
    var parameters: [String : String]? = nil
    var body: [String : Any]? = nil
    var headers: [String : String]? = nil
}

class ProductListService: ProductService {
    private let networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func fetchProducts() -> AnyPublisher<ProductsListModel, NetworkError> {
        let productServiceRequest = ProductListServiceRequest()
        
        return Future { promise in
            Task {
                do {
                    let productList = try await self.networkService.executeRequest(request: productServiceRequest)
                    promise(.success(productList))
                } catch let error as NetworkError {
                    promise(.failure(error))
                } catch {
                    promise(.failure(.customError(error.localizedDescription)))
                }
            }
        }
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
}
