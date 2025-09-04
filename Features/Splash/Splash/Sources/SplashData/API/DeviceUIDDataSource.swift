import Domain

public protocol DeviceUIDDataSource {
    func getDeviceUID(appType: String, appVersion: String) async throws -> String
}
