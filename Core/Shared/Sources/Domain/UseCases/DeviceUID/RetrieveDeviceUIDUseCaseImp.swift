public protocol RetrieveDeviceUIDUseCase {
    func execute() throws -> String?
}

public struct RetrieveDeviceUIDUseCaseImp: RetrieveDeviceUIDUseCase {
    private let repository: DeviceUIDRepository
    
    public init(repository: DeviceUIDRepository) {
        self.repository = repository
    }
    
    public func execute() throws -> String? {
        do {
            return try repository.getDeviceUID()
        } catch {
            throw error
        }
    }
}
