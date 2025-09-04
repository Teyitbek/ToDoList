import Foundation

public protocol DeviceSecretRepository {
    func getRemoteDeviceSecret() async throws -> DeviceSecret
    
    func save(deviceSecret: DeviceSecret) throws
    func retrieveDeviceSecret() throws -> DeviceSecret?
    func deleteDeviceSecret() throws
}
