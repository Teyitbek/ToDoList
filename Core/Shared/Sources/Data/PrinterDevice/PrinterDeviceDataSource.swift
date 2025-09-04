import Domain

public protocol PrinterDeviceDataSource {
    func getPrinterDevice() throws -> PrinterDevice?
    func save(printerDevice: PrinterDevice) throws
    func deletePrinterDevice() throws
}
