import Domain
import Foundation

public protocol UserKeychainDataSource {
    func save(user: UserRepresentable) throws
    func retrieve() throws -> UserRepresentable?
    func delete() throws
}

public final class UserKeychainDataSourceImpl: UserKeychainDataSource {
    private let service: SecureStorage

    public init(service: SecureStorage) {
        self.service = service
    }
    
    public func save(user: UserRepresentable) throws {
        try service.save(key: KeychainKeys.User.profile, value: UserDTO(from: user))
    }
    
    public func retrieve() throws -> UserRepresentable? {
        if let dto: UserDTO = try service.retrieve(key: KeychainKeys.User.profile) {
            return dto.toDomain()
        }
        return nil
    }

    public func delete() throws {
        try service.delete(key: KeychainKeys.User.profile)
    }
}
