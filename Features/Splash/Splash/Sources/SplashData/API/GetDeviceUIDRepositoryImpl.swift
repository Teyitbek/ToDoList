import SplashDomain

public struct GetDeviceUIDRepositoryImpl: GetDeviceUIDRepository {
    private let dataSource: DeviceUIDDataSource
    
    public init(dataSource: DeviceUIDDataSource) {
        self.dataSource = dataSource
    }
    
    public func getDeviceUID(appType: String, appVersion: String) async throws -> String {
        try await dataSource.getDeviceUID(appType: appType, appVersion: appVersion)
    }
}
