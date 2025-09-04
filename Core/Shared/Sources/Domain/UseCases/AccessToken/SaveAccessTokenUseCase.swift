public protocol SaveAccessTokenUseCase {
    func execute(with token: Tokenizable) throws
}

public struct SaveAccessTokenUseCaseImpl: SaveAccessTokenUseCase {
    private let repository: AccessTokenRepository
    
    public init(repository: AccessTokenRepository) {
        self.repository = repository
    }
    
    public func execute(with token: Tokenizable) throws {
        do {
            try repository.save(accessToken: token)
        } catch {
            throw error
        }
    }
}
