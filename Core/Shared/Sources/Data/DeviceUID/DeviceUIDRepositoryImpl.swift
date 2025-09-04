import Domain

public struct DeviceUIDRepositoryImpl: DeviceUIDRepository {
    private let dataSource: DeviceUIDUserDefaultsDataSource
    
    public init(dataSource: DeviceUIDUserDefaultsDataSource) {
        self.dataSource = dataSource
    }
    
    public func save(deviceUID: String) throws {
        try dataSource.save(deviceUID: deviceUID)
    }
    
    public func getDeviceUID() throws -> String? {
        try dataSource.retrieve()
    }
    
    public func deleteDeviceUID() throws {
        try dataSource.deleteDeviceUID()
    }
}
