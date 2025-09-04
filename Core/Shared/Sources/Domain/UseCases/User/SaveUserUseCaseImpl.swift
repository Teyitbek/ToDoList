public protocol SaveUserUseCase {
    func execute(with token: UserRepresentable) throws
}

public struct SaveUserUseCaseImpl: SaveUserUseCase {
    private let repository: UserRepository
    
    public init(repository: UserRepository) {
        self.repository = repository
    }
    
    public func execute(with user: UserRepresentable) throws {
        do {
            try repository.save(user: user)
        } catch {
            throw error
        }
    }
}
