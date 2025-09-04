import Domain
import Foundation

public protocol LocationKeychainDataSource {
    func save(location: Locationable) throws
    func retrieve() throws -> Locationable?
    func deleteLocation() throws
}

public final class LocationKeychainDataSourceImpl: LocationKeychainDataSource {
    private let service: SecureStorage

    public init(service: SecureStorage) {
        self.service = service
    }
    
    public func save(location: Locationable) throws {
        try service.save(key: KeychainKeys.Auth.location, value: LocationDTO(id: location.id, name: location.name))
    }
    
    public func retrieve() throws -> Locationable? {
        if let dto: LocationDTO = try service.retrieve(key: KeychainKeys.Auth.location) {
            return dto.toDomain()
        }
        return nil
    }

    public func deleteLocation() throws {
        try service.delete(key: KeychainKeys.Auth.location)
    }
}
