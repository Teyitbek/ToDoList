import LoginDomain

final class GetTokenUseCase: GetTokenUseCaseProtocol {
    private let repository: TokenRepositoryProtocol
    
    init(repository: TokenRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute() throws -> Token? {
        try repository.fetchToken()
    }
}
