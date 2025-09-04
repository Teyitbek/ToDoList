public struct GetProductDetailsUseCaseImpl: GetProductDetailsUseCase {
    private let repository: ProductRepository
    
    public init(repository: ProductRepository) {
        self.repository = repository
    }
    
    public func execute(with productId: Int, type: ProductDetailType) async throws -> ProductDetails {
        try await repository.getProductDetails(wiht: productId, type: type)
    }
}

