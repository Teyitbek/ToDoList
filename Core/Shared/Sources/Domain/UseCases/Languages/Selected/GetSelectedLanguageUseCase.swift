public protocol GetSelectedLanguageUseCase {
    func execute() throws -> LanguageRepresentable?
}

public struct GetSelectedLanguageUseCaseImpl: GetSelectedLanguageUseCase {
    private let repository: LanguagesLocalRepository
    
    public init(repository: LanguagesLocalRepository) {
        self.repository = repository
    }
    
    public func execute() throws -> LanguageRepresentable? {
        do {
            return try repository.retrieveSelectedLanguage()
        } catch {
            throw error
        }
    }
}

