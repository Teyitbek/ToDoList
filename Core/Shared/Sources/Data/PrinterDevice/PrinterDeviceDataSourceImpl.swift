import Domain
import RealHTTP

public struct PrinterDeviceDataSourceImpl: PrinterDeviceDataSource {
    private let service: PersistentStorage
    
    public init(service: PersistentStorage) {
        self.service = service
    }
    
    public func getPrinterDevice() throws -> PrinterDevice? {
        if let dto: PrinterDeviceDTO = try service.retrieve(key: UserDefaultsKeys.printerDevice) {
            return dto.toDomain()
        }
        
        return nil
    }
    
    public func save(printerDevice: Domain.PrinterDevice) throws {
        try service.save(key: UserDefaultsKeys.printerDevice, value: PrinterDeviceDTO(name: printerDevice.name,
                                                                                      ipAddress: printerDevice.ipAddress,
                                                                                      modelName: printerDevice.modelName,
                                                                                      target: printerDevice.target,
                                                                                      macAddress: printerDevice.macAddress))
    }
    
    public func deletePrinterDevice() throws {
        try service.delete(key: UserDefaultsKeys.printerDevice)
    }
}
