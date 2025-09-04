import Domain
import RealHTTP

public struct TerminalDeviceDataSourceImpl: TerminalDeviceDataSource {
    private let service: PersistentStorage
    
    public init(service: PersistentStorage) {
        self.service = service
    }
    
    public func getTerminalDevice() throws -> TerminalDevice? {
        if let dto: TerminalDeviceDTO = try service.retrieve(key: UserDefaultsKeys.terminalDevice) {
            return dto.toDomain()
        }
        
        return nil
    }
    
    public func save(terminalDevice: Domain.TerminalDevice) throws {
        try service.save(key: UserDefaultsKeys.terminalDevice, value: TerminalDeviceDTO(name: terminalDevice.name,
                                                                                        serialNumber: terminalDevice.serialNumber))
    }
    
    public func deleteTerminalDevice() throws {
        try service.delete(key: UserDefaultsKeys.terminalDevice)
    }
}
