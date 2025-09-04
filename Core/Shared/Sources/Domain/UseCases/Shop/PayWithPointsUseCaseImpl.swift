public struct PayWithPointsUseCaseImpl: PayWithPointsUseCase {
    private let repository: ShopRepository
    
    public init(repository: ShopRepository) {
        self.repository = repository
    }
    
    public func execute() async throws -> String? {
        try await repository.payWithPoints()
    }
}
