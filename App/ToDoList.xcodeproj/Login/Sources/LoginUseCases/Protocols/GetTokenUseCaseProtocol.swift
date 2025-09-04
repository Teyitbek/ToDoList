import LoginDomain

protocol GetTokenUseCaseProtocol {
    func execute() throws -> Token?
}
