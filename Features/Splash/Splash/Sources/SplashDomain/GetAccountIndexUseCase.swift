import Domain

public protocol GetAccountIndexUseCase {
    func execute() async throws -> UserRepresentable
}

public struct GetAccountIndexUseCaseImpl: GetAccountIndexUseCase {
    private let repository: AccountIndexRepository

    public init(repository: AccountIndexRepository) {
        self.repository = repository
    }
    
    public func execute() async throws -> UserRepresentable {
        try await repository.getIndex()
    }
}
