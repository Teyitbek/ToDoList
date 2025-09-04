public protocol ProductRepository {
    func getProductDetails(wiht productId: Int, type: ProductDetailType) async throws -> ProductDetails
}
