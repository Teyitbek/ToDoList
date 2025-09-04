public protocol DeleteTerminalDeviceUseCase {
    func execute() throws
}

public struct DeleteTerminalDeviceUseCaseImpl: DeleteTerminalDeviceUseCase {
    private let repository: TerminalDeviceRepository
    
    public init(repository: TerminalDeviceRepository) {
        self.repository = repository
    }
    
    public func execute() throws {
        do {
            return try repository.deleteTerminalDevice()
        } catch {
            throw error
        }
    }
}
