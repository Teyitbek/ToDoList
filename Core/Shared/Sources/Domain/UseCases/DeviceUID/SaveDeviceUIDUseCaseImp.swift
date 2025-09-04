public protocol SaveDeviceUIDUseCase {
    func execute(with deviceUID: String) throws
}

public struct SaveDeviceUIDUseCaseImp: SaveDeviceUIDUseCase {
    private let repository: DeviceUIDRepository
    
    public init(repository: DeviceUIDRepository) {
        self.repository = repository
    }
    
    public func execute(with deviceUID: String) throws {
        do {
            try repository.save(deviceUID: deviceUID)
        } catch {
            throw error
        }
    }
}
