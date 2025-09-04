import Domain
import RealHTTP

public struct DeviceSecretDataSourceImpl: DeviceSecretDataSource {
    private let client: HTTPClient
    private let service: PersistentStorage
    
    public init(client: HTTPClient, service: PersistentStorage) {
        self.client = client
        self.service = service
    }
    
    public func getRemoteDeviceSecret() async throws -> DeviceSecret {
        try await client.fetch(GetDeviceSecretRequestDTO()).toDomain()
    }
    
    public func save(deviceSecret: DeviceSecret) throws {
        try service.save(key: UserDefaultsKeys.deviceSecret, value: DeviceSecretDTO(location: deviceSecret.location, secret: deviceSecret.secret))
    }
    
    public func retrieveDeviceSecret() throws -> DeviceSecret? {
        if let dto: DeviceSecretDTO = try service.retrieve(key: UserDefaultsKeys.deviceSecret) {
            return dto.toDomain()
        }
        
        return nil
    }
    
    public func deleteDeviceSecret() throws {
        try service.delete(key: UserDefaultsKeys.deviceSecret)
    }
}
