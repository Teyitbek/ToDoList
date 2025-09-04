import Foundation

public protocol GetDeviceUIDUseCase {
    func execute(appType: String, appVersion: String) async throws -> String
}
