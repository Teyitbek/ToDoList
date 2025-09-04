public protocol DeleteAccessTokenUseCase {
    func execute() throws
}

public struct DeleteAccessTokenUseCaseImpl: DeleteAccessTokenUseCase {
    private let repository: AccessTokenRepository
    
    public init(repository: AccessTokenRepository) {
        self.repository = repository
    }
    
    public func execute() throws {
        do {
            return try repository.deleteToken()
        } catch {
            throw error
        }
    }
}
