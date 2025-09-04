import Foundation

public protocol GetTerminalDeviceUseCase {
    func execute() throws -> TerminalDevice?
}

public struct GetTerminalDeviceUseCaseImpl: GetTerminalDeviceUseCase {
    private let repository: TerminalDeviceRepository
    
    public init(repository: TerminalDeviceRepository) {
        self.repository = repository
    }
    
    public func execute() throws -> TerminalDevice? {
        do {
            return try repository.getTerminalDevice()
        } catch {
            throw error
        }
    }
}

