public protocol DeleteUserUseCase {
    func execute() throws
}

public struct DeleteUserUseCaseImpl: DeleteUserUseCase {
    private let repository: UserRepository
    
    public init(repository: UserRepository) {
        self.repository = repository
    }
    
    public func execute() throws {
        do {
            return try repository.delete()
        } catch {
            throw error
        }
    }
}
