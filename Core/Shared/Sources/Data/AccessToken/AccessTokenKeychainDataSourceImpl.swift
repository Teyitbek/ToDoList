import Domain
import Foundation

public protocol AccessTokenKeychainDataSource {
    func save(accessToken: Tokenizable) throws
    func retrieve() throws -> Tokenizable?
    func deleteToken() throws
}

public final class AccessTokenKeychainDataSourceImpl: AccessTokenKeychainDataSource {
    private let service: SecureStorage

    public init(service: SecureStorage) {
        self.service = service
    }
    
    public func save(accessToken: Tokenizable) throws {
        try service.save(key: KeychainKeys.Auth.accessToken, value: AccessTokenDTO(accessToken: accessToken.accessToken))
    }
    
    public func retrieve() throws -> Tokenizable? {
        if let dto: AccessTokenDTO = try service.retrieve(key: KeychainKeys.Auth.accessToken) {
            return dto.toDomain()
        }
        return nil
    }

    public func deleteToken() throws {
        try service.delete(key: KeychainKeys.Auth.accessToken)
    }
}
