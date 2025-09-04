import Domain
import Foundation

public struct DeviceUIDUserDefaultsDataSourceImpl: DeviceUIDUserDefaultsDataSource {
    private let service: PersistentStorage

    public init(service: PersistentStorage) {
        self.service = service
    }
    
    public func save(deviceUID: String) throws {
        try service.save(key: UserDefaultsKeys.deviceUID, value: deviceUID)
    }
    
    public func retrieve() throws -> String? {
        if let deviceUID: String = try service.retrieve(key: UserDefaultsKeys.deviceUID) {
            return deviceUID
        }
        return nil
    }

    public func deleteDeviceUID() throws {
        try service.delete(key: UserDefaultsKeys.deviceUID)
    }
}
