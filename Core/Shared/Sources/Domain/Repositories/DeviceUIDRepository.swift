import Foundation

public protocol DeviceUIDRepository {
    func save(deviceUID: String) throws
    func getDeviceUID() throws -> String?
    func deleteDeviceUID() throws
}
