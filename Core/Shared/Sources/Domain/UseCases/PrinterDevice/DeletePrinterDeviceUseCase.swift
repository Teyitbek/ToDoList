public protocol DeletePrinterDeviceUseCase {
    func execute() throws
}

public struct DeletePrinterDeviceUseCaseImpl: DeletePrinterDeviceUseCase {
    private let repository: PrinterDeviceRepository
    
    public init(repository: PrinterDeviceRepository) {
        self.repository = repository
    }
    
    public func execute() throws {
        do {
            return try repository.deletePrinterDevice()
        } catch {
            throw error
        }
    }
}
