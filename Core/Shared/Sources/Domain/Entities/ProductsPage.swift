import Foundation

@preconcurrency
public class ProductsPage: PaginationResponseRepresentable {
    public var data: [ProductRepresentable]
    public var message: String?
    public var perPage: Int
    public var page: Int
    public var totalPage: Int
    public var totalItems: Int
    
    public init(data: [ProductRepresentable], message: String? = nil, perPage: Int, page: Int, totalPage: Int, totalItems: Int) {
        self.data = data
        self.message = message
        self.perPage = perPage
        self.page = page
        self.totalPage = totalPage
        self.totalItems = totalItems
    }
}
