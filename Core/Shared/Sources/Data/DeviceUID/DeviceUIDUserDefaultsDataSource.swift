import Foundation

public protocol DeviceUIDUserDefaultsDataSource {
    func save(deviceUID: String) throws
    func retrieve() throws -> String?
    func deleteDeviceUID() throws
}
