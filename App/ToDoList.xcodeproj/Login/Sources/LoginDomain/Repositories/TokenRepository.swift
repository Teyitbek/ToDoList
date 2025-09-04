final class TokenRepository: TokenRepositoryProtocol {
    let localDataSource: TokenDataSource
    let remoteDataSource: TokenDataSource
    
    init(localDataSource: TokenDataSource, remoteDataSource: TokenDataSource) {
        self.localDataSource = localDataSource
        self.remoteDataSource = remoteDataSource
    }
    
    func fetchToken() throws -> Token? {
        try localDataSource.fetchToken()
    }
    
    func deleteToken() {
        localDataSource.deleteToken()
    }
    
    func save(token: Token) throws {
        try localDataSource.save(token: token)
    }
}
