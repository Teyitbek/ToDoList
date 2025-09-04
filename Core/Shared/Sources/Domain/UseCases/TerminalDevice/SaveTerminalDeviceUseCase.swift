public protocol SaveTerminalDeviceUseCase {
    func execute(terminalDevice: TerminalDevice) throws
}

public struct SaveTerminalDeviceUseCaseImpl: SaveTerminalDeviceUseCase {
    private let repository: TerminalDeviceRepository
    
    public init(repository: TerminalDeviceRepository) {
        self.repository = repository
    }
    
    public func execute(terminalDevice: TerminalDevice) throws {
        do {
            return try repository.save(terminalDevice: terminalDevice)
        } catch {
            throw error
        }
    }
}

