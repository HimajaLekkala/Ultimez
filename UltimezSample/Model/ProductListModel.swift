import Foundation

struct ProductsListModel: Codable {
    var results: [ProductsListResultModel]
    var pagination: ProductsListPaginationModel?
}

struct ProductsListResultModel: Codable, Hashable {
    var createdAt: String
    var price: String
    var name: String
    var uid: String
    var imageIDs: [String]
    var imageURLs: [String]
    var imageURLsThumbnails: [String]
    
    enum CodingKeys: String, CodingKey {
        case createdAt = "created_at"
        case price, name, uid
        case imageIDs = "image_ids"
        case imageURLs = "image_urls"
        case imageURLsThumbnails = "image_urls_thumbnails"
    }
}

struct ProductsListPaginationModel: Codable {
    var key: String?
}
