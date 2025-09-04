import Foundation

public struct GenericPaginationResponse<T: Decodable>: Decodable {
    public var data: T
    public var message: String?
    public let perPage: Int
    public let page: Int
    public let totalPage: Int
    public let totalItems: Int
    
    public init(data: T, message: String, perPage: Int, page: Int, totalPage: Int, totalItems: Int) {
        self.data = data
        self.message = message
        self.perPage = perPage
        self.page = page
        self.totalPage = totalPage
        self.totalItems = totalItems
    }
}

extension GenericPaginationResponse where T: DomainMappable {
    public func toDomain() -> T.DomainModel {
        return data.toDomain()
    }
}
