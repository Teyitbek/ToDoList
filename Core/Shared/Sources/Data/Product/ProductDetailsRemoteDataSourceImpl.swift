import Domain
import RealHTTP

public struct ProductDetailsRemoteDataSourceImpl: ProductDetailsRemoteDataSource {
    private let client: HTTPClient
    
    public init(client: HTTPClient) {
        self.client = client
    }

    public func getProductDetails(with productId: Int, type: ProductDetailType) async throws -> ProductDetails {
        try await client.fetch(ProductDetailsRequest(productId: productId, type: type)).toDomain()
    }
}
