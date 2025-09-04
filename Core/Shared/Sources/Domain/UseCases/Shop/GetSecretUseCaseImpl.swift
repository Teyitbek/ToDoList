import Foundation

public struct GetSecretUseCaseImpl: GetSecretUseCase {
    private let repository: ShopRepository
    
    public init(repository: ShopRepository) {
        self.repository = repository
    }
    
    public func execute() async throws -> Secret {
        try await repository.getSecret()
    }
}
