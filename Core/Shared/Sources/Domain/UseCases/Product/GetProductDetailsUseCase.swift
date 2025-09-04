public protocol GetProductDetailsUseCase {
    func execute(with productId: Int, type: ProductDetailType) async throws -> ProductDetails
}
