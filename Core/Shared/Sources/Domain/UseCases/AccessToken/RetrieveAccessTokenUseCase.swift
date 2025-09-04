public protocol RetrieveAccessTokenUseCase {
    func execute() throws -> Tokenizable?
}

public struct RetrieveAccessTokenUseCaseImpl: RetrieveAccessTokenUseCase {
    private let repository: AccessTokenRepository
    
    public init(repository: AccessTokenRepository) {
        self.repository = repository
    }
    
    public func execute() throws -> Tokenizable? {
        do {
            return try repository.getAccessToken()
        } catch {
            throw error
        }
    }
}
