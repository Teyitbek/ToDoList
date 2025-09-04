import Domain
import RealHTTP

public struct DeviceUIDDataSourceImpl: DeviceUIDDataSource {
    private let client: HTTPClient
    
    public init(client: HTTPClient) {
        self.client = client
    }
    
    public func getDeviceUID(appType: String, appVersion: String) async throws -> String {
        try await client.fetch(DeviceUIDRequestDTO(appType: appType, appVersion: appVersion)).uid
    }
}
