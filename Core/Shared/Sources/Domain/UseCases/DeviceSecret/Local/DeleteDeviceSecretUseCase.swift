public protocol DeleteDeviceSecretUseCase {
    func execute() throws
}

public struct DeleteDeviceSecretUseCaseImpl: DeleteDeviceSecretUseCase {
    private let repository: DeviceSecretRepository
    
    public init(repository: DeviceSecretRepository) {
        self.repository = repository
    }
    
    public func execute() throws {
        do {
            return try repository.deleteDeviceSecret()
        } catch {
            throw error
        }
    }
}
