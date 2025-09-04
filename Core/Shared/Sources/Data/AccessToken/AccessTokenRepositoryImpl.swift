import Domain

public final class AccessTokenRepositoryImpl: AccessTokenRepository {
    private let dataSource: AccessTokenKeychainDataSource
    
    public init(dataSource: AccessTokenKeychainDataSource) {
        self.dataSource = dataSource
    }
    
    public func save(accessToken: Tokenizable) throws {
        try dataSource.save(accessToken: AccessToken(accessToken: accessToken.accessToken))
    }
    
    public func getAccessToken() throws -> Tokenizable? {
        try dataSource.retrieve()
    }
    
    public func deleteToken() throws {
        try dataSource.deleteToken()
    }
}
