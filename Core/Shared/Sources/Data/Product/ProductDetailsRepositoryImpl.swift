import Domain

public struct ProductDetailsRepositoryImpl: ProductRepository {
    let dataSource: ProductDetailsRemoteDataSource
        
    public init(dataSource: ProductDetailsRemoteDataSource) {
        self.dataSource = dataSource
    }
    
    public func getProductDetails(wiht productId: Int, type: ProductDetailType) async throws -> ProductDetails {
        try await dataSource.getProductDetails(with: productId, type: type)
    }
}
