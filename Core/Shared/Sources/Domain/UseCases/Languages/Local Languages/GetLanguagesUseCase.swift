public protocol GetLanguagesUseCase {
    func execute() throws -> [LanguageRepresentable]
}

public struct GetLanguagesUseCaseImpl: GetLanguagesUseCase {
    private let repository: LanguagesLocalRepository
    
    public init(repository: LanguagesLocalRepository) {
        self.repository = repository
    }
    
    public func execute() throws -> [LanguageRepresentable] {
        do {
            return try repository.retrieveLocalLanguages()
        } catch {
            throw error
        }
    }
}

