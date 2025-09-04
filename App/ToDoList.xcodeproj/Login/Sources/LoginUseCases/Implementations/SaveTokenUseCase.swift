import LoginDomain

final class SaveTokenUseCase: SaveTokenUseCaseProdtocol {
    private let repository: TokenRepositoryProtocol
    
    init(repository: TokenRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(with token: Token) {
        repository.deleteToken()
    }
}
