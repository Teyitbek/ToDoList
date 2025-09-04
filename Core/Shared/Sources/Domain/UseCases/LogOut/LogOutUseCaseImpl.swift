public struct LogOutUseCaseImpl: LogOutUseCase {
    private let repository: LogOutRepository
    
    public init(repository: LogOutRepository) {
        self.repository = repository
    }
    
    public func execute() async throws -> String? {
        try await repository.logOut()
    }
}
