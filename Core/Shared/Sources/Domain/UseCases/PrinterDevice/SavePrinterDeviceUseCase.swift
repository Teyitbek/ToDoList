public protocol SavePrinterDeviceUseCase {
    func execute(printerDevice: PrinterDevice) throws
}

public struct SavePrinterDeviceUseCaseImpl: SavePrinterDeviceUseCase {
    private let repository: PrinterDeviceRepository
    
    public init(repository: PrinterDeviceRepository) {
        self.repository = repository
    }
    
    public func execute(printerDevice: PrinterDevice) throws {
        do {
            return try repository.save(printerDevice: printerDevice)
        } catch {
            throw error
        }
    }
}

