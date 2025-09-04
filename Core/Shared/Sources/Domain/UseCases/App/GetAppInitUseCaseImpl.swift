import Foundation

public struct GetAppInitUseCaseImpl: GetAppInitUseCase {
    private let repository: AppRepository
    
    public init(repository: AppRepository) {
        self.repository = repository
    }
    
    public func execute() async throws -> AppInit {
        try await repository.getAppInit()
    }
}
