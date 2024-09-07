import Foundation

protocol NetworkService {
    func executeRequest<T: APIRequest>(request: T) async throws -> T.Response
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case decodingFailed
    case customError(String)
}

protocol APIRequest {
    var url: String { get }
    var parameters: [String: String]? { get }
    var body: [String: Any]? { get }
    var method: HTTPMethod { get }
    var headers: [String: String]? { get }
    associatedtype Response: Codable
}

class NetworkManager: NetworkService {
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func executeRequest<T: APIRequest>(request: T) async throws -> T.Response {
        let url = try buildURL(request: request)
        let urlRequest = try createURLRequest(request: request, url: url)
        let (data, _) = try await session.data(for: urlRequest)
        return try decodeResponse(data: data, as: T.Response.self)
    }
    
    private func buildURL<T: APIRequest>(request: T) throws -> URL {
        guard var urlComponents = URLComponents(string: request.url) else {
            throw NetworkError.invalidURL
        }
        
        if let parameters = request.parameters {
            urlComponents.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
        }
        
        guard let url = urlComponents.url else {
            throw NetworkError.invalidURL
        }
        
        return url
    }
    
    private func createURLRequest<T: APIRequest>(request: T, url: URL) throws -> URLRequest {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        
        if let headers = request.headers {
            for (key, value) in headers {
                urlRequest.setValue(value, forHTTPHeaderField: key)
            }
        }
        
        if let body = request.body {
            urlRequest.httpBody = try JSONSerialization.data(withJSONObject: body)
        }
        
        return urlRequest
    }
    
    private func decodeResponse<T: Decodable>(data: Data, as type: T.Type) throws -> T {
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw NetworkError.decodingFailed
        }
    }
}
