import Domain
import Foundation
import RealHTTP

public struct OrderRemoteDataSource: OrderDataSource {
    private let client: HTTPClient
    
    public init(client: HTTPClient) {
        self.client = client
    }
    
    public func getOrderItemDetails(with id: Int) async throws -> ProductDetails {
        try await client.fetch(GetOrderItemDetailsRequestDTO(id: id)).toDomain()
    }
    
    public func postOrderItemDetails(with id: Int, details: CartProduct) async throws -> Cart {
        try await client.fetch(PostOrderItemDetailsRequestDTO(id: id, details: AddToCartRequestDTO(from: details))).toDomain()
    }
}
