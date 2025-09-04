import Domain
import Foundation

public struct LanguagesDTO: Codable, DomainMappable {
    var id: String
    var title: String
    var originalTitle: String
    var code: String
    var icon: String
    
    public init(id: String, title: String, originalTitle: String, code: String, icon: String) {
        self.id = id
        self.title = title
        self.originalTitle = originalTitle
        self.code = code
        self.icon = icon
    }
}

public extension LanguagesDTO {
    func toDomain() -> Language {
        Language(id: id, title: title, originalTitle: originalTitle, code: code, icon: icon)
    }
}
