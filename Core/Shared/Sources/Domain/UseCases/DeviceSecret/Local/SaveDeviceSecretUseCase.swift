public protocol SaveDeviceSecretUseCase {
    func execute(deviceSecret: DeviceSecret) throws
}

public struct SaveDeviceSecretUseCaseImpl: SaveDeviceSecretUseCase {
    private let repository: DeviceSecretRepository
    
    public init(repository: DeviceSecretRepository) {
        self.repository = repository
    }
    
    public func execute(deviceSecret: DeviceSecret) throws {
        do {
            return try repository.save(deviceSecret: deviceSecret)
        } catch {
            throw error
        }
    }
}
