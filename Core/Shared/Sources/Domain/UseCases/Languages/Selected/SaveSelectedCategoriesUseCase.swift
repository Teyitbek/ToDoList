//public protocol SaveSelectedLanguageUseCase {
//    func execute(language: LanguageRepresentable) throws
//}
//
//public struct SaveSelectedLanguageUseCaseImpl: SaveSelectedLanguageUseCase {
//    private let repository: LanguagesLocalRepository
//    
//    public init(repository: LanguagesLocalRepository) {
//        self.repository = repository
//    }
//    
//    public func execute(language: LanguageRepresentable) throws {
//        do {
//            return try repository.saveSelected(language: language)
//        } catch {
//            throw error
//        }
//    }
//}
