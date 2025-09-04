//public protocol SaveLanguagesUseCase {
//    func execute(languages: [LanguageRepresentable]) throws
//}
//
//public struct SaveLanguagesUseCaseImpl: SaveLanguagesUseCase {
//    private let repository: LanguagesLocalRepository
//    
//    public init(repository: LanguagesLocalRepository) {
//        self.repository = repository
//    }
//    
//    public func execute(languages: [LanguageRepresentable]) throws {
//        do {
//            return try repository.save(languages: languages)
//        } catch {
//            throw error
//        }
//    }
//}
//
