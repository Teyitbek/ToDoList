import Foundation

public protocol PrinterDeviceRepository {
    func getPrinterDevice() throws -> PrinterDevice?
    func save(printerDevice: PrinterDevice) throws
    func deletePrinterDevice() throws
}
