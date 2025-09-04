import Domain
import RealHTTP

public protocol LanguagesLocalDataSource {
    func save(languages: [LanguageRepresentable]) throws
    func retrieveLocalLanguages() throws -> [LanguageRepresentable]
    func deleteLocalLanguages() throws
    
    func saveSelected(language: LanguageRepresentable) throws
    func retrieveSelectedLanguage() throws -> LanguageRepresentable?
    func deleteSelectedLanguage() throws
    
    func save(labels: [String: String]) throws
    func retrieveLabels(for language: String) -> [String: String]
}

public struct LanguagesLocalDataSourceImpl: LanguagesLocalDataSource {
    private let service: PersistentStorage
    
    public init(service: PersistentStorage) {
        self.service = service
    }
    
    public func save(languages: [LanguageRepresentable]) throws {
        try service.save(key: UserDefaultsKeys.languages, value: languages.map({ LanguagesDTO(id: $0.id, title: $0.title, originalTitle: $0.originalTitle, code: $0.code, icon: $0.icon) }))
    }
    
    public func retrieveLocalLanguages() throws -> [LanguageRepresentable] {
        if let dto: [LanguagesDTO] = try service.retrieve(key: UserDefaultsKeys.languages) {
            return dto.map { $0.toDomain() }
        }
        
        return []
    }
    public func deleteLocalLanguages() throws {
        try service.delete(key: UserDefaultsKeys.languages)
    }
    
    public func saveSelected(language: LanguageRepresentable) throws {
        try service.save(key: UserDefaultsKeys.selectedLanguage, value: LanguagesDTO(id: language.id, title: language.title, originalTitle: language.originalTitle, code: language.code, icon: language.icon))
    }
    
    public func retrieveSelectedLanguage() throws -> LanguageRepresentable? {
        if let dto: LanguagesDTO = try service.retrieve(key: UserDefaultsKeys.selectedLanguage) {
            return dto.toDomain()
        }
        
        return nil
    }
    
    public func deleteSelectedLanguage() throws {
        try service.delete(key: UserDefaultsKeys.selectedLanguage)
    }
    
    public func save(labels: [String : String]) throws {
        try service.save(key: UserDefaultsKeys.labels, value: labels)
    }
    
    public func retrieveLabels(for language: String) -> [String : String] {
        do {
            if let dto: [String: String] = try service.retrieve(key: UserDefaultsKeys.labels) {
                return dto
            }
            
            return [:]
        } catch {
            return [:]
        }
    }
}
