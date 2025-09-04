import Foundation

public protocol LanguagesLocalRepository {
    func save(languages: [LanguageRepresentable]) throws
    func retrieveLocalLanguages() throws -> [LanguageRepresentable]
    func deleteLocalLanguages() throws
    
    func saveSelected(language: LanguageRepresentable) throws
    func retrieveSelectedLanguage() throws -> LanguageRepresentable?
    func deleteSelectedLanguage() throws
    
    func save(labels: [String:String]) throws
}
