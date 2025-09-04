import Domain

public struct PrinterDeviceRepositoryImpl: PrinterDeviceRepository {
    private let dataSource: PrinterDeviceDataSource
    
    public init(dataSource: PrinterDeviceDataSource) {
        self.dataSource = dataSource
    }
    
    public func getPrinterDevice() throws -> PrinterDevice? {
        try dataSource.getPrinterDevice()
    }
    
    public func save(printerDevice: PrinterDevice) throws {
        try dataSource.save(printerDevice: printerDevice)
    }
    
    public func deletePrinterDevice() throws {
        try dataSource.deletePrinterDevice()
    }
}
