import Foundation
import UIKit

public protocol LanguageRepresentable: Sendable {
    var id: String { get }
    var title: String { get }
    var originalTitle: String { get }
    var code: String { get }
    var icon: String { get }
    var iconCashed: UIImage? { get set }
}

public struct Language: LanguageRepresentable {
    public var id: String
    public var title: String
    public var originalTitle: String
    public var code: String
    public var icon: String
    public var isSelected: Bool = false
    public var iconCashed: UIImage?
    
    public init(id: String, title: String, originalTitle: String, code: String, icon: String) {
        self.id = id
        self.title = title
        self.originalTitle = originalTitle
        self.code = code
        self.icon = icon
        self.iconCashed = nil
    }
}
