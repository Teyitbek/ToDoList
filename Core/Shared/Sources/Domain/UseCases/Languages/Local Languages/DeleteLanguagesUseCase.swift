public protocol DeleteLanguagesUseCase {
    func execute() throws
}

public struct DeleteLanguagesUseCaseImpl: DeleteLanguagesUseCase {
    private let repository: LanguagesLocalRepository
    
    public init(repository: LanguagesLocalRepository) {
        self.repository = repository
    }
    
    public func execute() throws {
        do {
            return try repository.deleteLocalLanguages()
        } catch {
            throw error
        }
    }
}
