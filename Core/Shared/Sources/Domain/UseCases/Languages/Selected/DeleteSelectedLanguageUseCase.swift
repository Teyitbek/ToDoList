public protocol DeleteSelectedLanguageUseCase {
    func execute() throws
}

public struct DeleteSelectedLanguageUseCaseImpl: DeleteSelectedLanguageUseCase {
    private let repository: LanguagesLocalRepository
    
    public init(repository: LanguagesLocalRepository) {
        self.repository = repository
    }
    
    public func execute() throws {
        do {
            return try repository.deleteSelectedLanguage()
        } catch {
            throw error
        }
    }
}
