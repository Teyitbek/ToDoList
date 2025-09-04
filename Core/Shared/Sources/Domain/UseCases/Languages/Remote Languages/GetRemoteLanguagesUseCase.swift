public protocol GetRemoteLanguagesUseCase {
    func execute() async throws -> [LanguageRepresentable]
}

public struct GetRemoteLanguagesUseCaseImpl: GetRemoteLanguagesUseCase {
    private let repository: LanguagesRemoteRepository
    
    public init(repository: LanguagesRemoteRepository) {
        self.repository = repository
    }
    
    public func execute() async throws -> [LanguageRepresentable] {
        try await repository.getLanguages()
    }
}
