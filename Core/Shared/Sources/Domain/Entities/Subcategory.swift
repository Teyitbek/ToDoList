import Foundation

public struct Subcategory: SubcategoryRepresentable, Sendable, Equatable {
    public var id: Int
    public var name: String
    
    public init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
    
    public static func == (lhs: Subcategory, rhs: Subcategory) -> Bool {
        return lhs.id == rhs.id &&
        lhs.name == rhs.name
    }
}
