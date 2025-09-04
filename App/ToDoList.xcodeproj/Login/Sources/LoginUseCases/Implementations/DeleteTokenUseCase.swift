import LoginDomain

final class DeleteTokenUseCase: DeleteTokenUseCaseProtocol {
    private let repository: TokenRepositoryProtocol
    
    init(repository: TokenRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute() {
        repository.deleteToken()
    }
}
