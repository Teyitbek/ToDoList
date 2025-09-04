public struct AddToCartUseCaseImpl: AddToCartUseCase {
    private let repository: ShopRepository
    
    public init(repository: ShopRepository) {
        self.repository = repository
    }
    
    public func execute(with product: CartProduct) async throws -> (cart: Cart, message:  String?) {
        try await repository.addToCart(product: product)
    }
}
