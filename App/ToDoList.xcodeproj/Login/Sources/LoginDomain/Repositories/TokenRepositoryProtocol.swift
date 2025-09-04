public protocol TokenRepositoryProtocol {
    func fetchToken() throws -> Token?
    func deleteToken()
    func save(token: Token) throws
}
