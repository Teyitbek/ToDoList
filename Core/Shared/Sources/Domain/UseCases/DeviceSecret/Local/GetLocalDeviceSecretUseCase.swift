public protocol GetLocalDeviceSecretUseCase {
    func execute() throws -> DeviceSecret?
}

public struct GetLocalDeviceSecretUseCaseImpl: GetLocalDeviceSecretUseCase {
    private let repository: DeviceSecretRepository
    
    public init(repository: DeviceSecretRepository) {
        self.repository = repository
    }
    
    public func execute() throws -> DeviceSecret? {
        do {
            return try repository.retrieveDeviceSecret()
        } catch {
            throw error
        }
    }
}

