public struct ClearCartUseCaseImpl: ClearCartUseCase {
    private let repository: ShopRepository
    
    public init(repository: ShopRepository) {
        self.repository = repository
    }
    
    public func execute() async throws -> Cart {
        try await repository.clearCart()
    }
}
