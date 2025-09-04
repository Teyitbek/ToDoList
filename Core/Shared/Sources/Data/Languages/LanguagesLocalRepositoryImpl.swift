import Domain

public struct LanguagesLocalRepositoryImpl: LanguagesLocalRepository {
    private let localDataSource: LanguagesLocalDataSource
    
    public init(localDataSource: LanguagesLocalDataSource) {
        self.localDataSource = localDataSource
    }
    
    public func save(languages: [any Domain.LanguageRepresentable]) throws {
        try localDataSource.save(languages: languages)
    }
    
    public func retrieveLocalLanguages() throws -> [any Domain.LanguageRepresentable] {
        try localDataSource.retrieveLocalLanguages()
    }
    
    public func deleteLocalLanguages() throws {
        try localDataSource.deleteLocalLanguages()
    }
    
    public func saveSelected(language: any Domain.LanguageRepresentable) throws {
        try localDataSource.saveSelected(language: language)
    }
    
    public func retrieveSelectedLanguage() throws -> (any Domain.LanguageRepresentable)? {
        try localDataSource.retrieveSelectedLanguage()
    }
    
    public func deleteSelectedLanguage() throws {
        try localDataSource.deleteSelectedLanguage()
    }
    
    public func save(labels: [String : String]) throws {
        try localDataSource.save(labels: labels)
    }
}
