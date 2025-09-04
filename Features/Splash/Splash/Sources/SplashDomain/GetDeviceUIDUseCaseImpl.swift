import Domain

public struct GetDeviceUIDUseCaseImpl: GetDeviceUIDUseCase {
    private let repository: GetDeviceUIDRepository

    public init(repository: GetDeviceUIDRepository) {
        self.repository = repository
    }
    
    public func execute(appType: String, appVersion: String) async throws -> String {
        try await repository.getDeviceUID(appType: appType, appVersion: appVersion)
    }
}
