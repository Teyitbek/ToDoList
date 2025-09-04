public struct UpdateQuantityUseCaseImpl: UpdateQuantityUseCase {
    private let repository: ShopRepository
    
    public init(repository: ShopRepository) {
        self.repository = repository
    }
    
    public func execute(with updateDetails: CartQuantityUpdate) async throws -> (cart: Cart, message:  String?) {
        try await repository.updateQuantity(with: updateDetails)
    }
}
