import Foundation

public protocol GetPrinterDeviceUseCase {
    func execute() throws -> PrinterDevice?
}

public struct GetPrinterDeviceUseCaseImpl: GetPrinterDeviceUseCase {
    private let repository: PrinterDeviceRepository
    
    public init(repository: PrinterDeviceRepository) {
        self.repository = repository
    }
    
    public func execute() throws -> PrinterDevice? {
        do {
            return try repository.getPrinterDevice()
        } catch {
            throw error
        }
    }
}

