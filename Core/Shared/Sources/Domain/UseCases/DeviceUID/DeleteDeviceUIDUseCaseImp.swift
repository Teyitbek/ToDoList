public protocol DeleteDeviceUIDUseCase {
    func execute() throws
}

public struct DeleteDeviceUIDUseCaseImp: DeleteDeviceUIDUseCase {
    private let repository: DeviceUIDRepository
    
    public init(repository: DeviceUIDRepository) {
        self.repository = repository
    }
    
    public func execute() throws {
        do {
            try repository.deleteDeviceUID()
        } catch {
            throw error
        }
    }
}
