import Domain
import Foundation

public struct OrderRepositoryImpl: OrderRepository {
    private let dataSource: OrderDataSource
    
    public init(dataSource: OrderDataSource) {
        self.dataSource = dataSource
    }
    
    public func getOrderItemDetails(with id: Int) async throws -> ProductDetails {
        try await dataSource.getOrderItemDetails(with: id)
    }
    
    public func postOrderItemDetails(with id: Int, details: CartProduct) async throws -> Cart {
        try await dataSource.postOrderItemDetails(with: id, details: details)
    }
}
