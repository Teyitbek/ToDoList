import Domain

public struct DeviceSecretRepositoryImpl: DeviceSecretRepository {
    private let dataSource: DeviceSecretDataSource
    
    public init(dataSource: DeviceSecretDataSource) {
        self.dataSource = dataSource
    }
    
    public func getRemoteDeviceSecret() async throws -> DeviceSecret {
        try await dataSource.getRemoteDeviceSecret()
    }
    
    public func save(deviceSecret: DeviceSecret) throws {
        try dataSource.save(deviceSecret: deviceSecret)
    }
    
    public func retrieveDeviceSecret() throws -> DeviceSecret? {
        try dataSource.retrieveDeviceSecret()
    }
    
    public func deleteDeviceSecret() throws {
        try dataSource.deleteDeviceSecret()
    }
}
