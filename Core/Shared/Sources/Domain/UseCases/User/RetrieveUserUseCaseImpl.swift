public protocol RetrieveUserUseCase {
    func execute() throws -> UserRepresentable?
}

public struct RetrieveUserUseCaseImpl: RetrieveUserUseCase {
    private let repository: UserRepository
    
    public init(repository: UserRepository) {
        self.repository = repository
    }
    
    public func execute() throws -> UserRepresentable? {
        do {
            return try repository.retrieveUser()
        } catch {
            throw error
        }
    }
}
