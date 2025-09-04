public protocol GetRemoteDeviceSecretUseCase {
    func execute() async throws -> DeviceSecret
}

public struct GetRemoteDeviceSecretUseCaseImpl: GetRemoteDeviceSecretUseCase {
    private let repository: DeviceSecretRepository
    
    public init(repository: DeviceSecretRepository) {
        self.repository = repository
    }
    
    public func execute() async throws -> DeviceSecret {
        try await repository.getRemoteDeviceSecret()
    }
}
