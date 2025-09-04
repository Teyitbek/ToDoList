import Foundation

public protocol GetDeviceUIDRepository {
    func getDeviceUID(appType: String, appVersion: String) async throws -> String
}
