import Domain

public protocol ProductDetailsRemoteDataSource {
    func getProductDetails(with productId: Int, type: ProductDetailType) async throws -> ProductDetails
}
