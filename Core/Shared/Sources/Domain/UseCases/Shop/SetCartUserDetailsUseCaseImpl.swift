public struct SetCartUserDetailsUseCaseImpl: SetCartUserDetailsUseCase {
    private let repository: ShopRepository
    
    public init(repository: ShopRepository) {
        self.repository = repository
    }
    
    public func execute(userDetails: CartUserDetails) async throws -> Cart {
        try await repository.set(userDetails: userDetails)
    }
}
