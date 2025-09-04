import Foundation

public protocol CatalogOptionRepresentable: Sendable, Equatable {
    var id: Int { get set }
    var name: String { get set }
    var description: String? { get set }
    var imageThumbnail: String? { get set }
    var image: String? { get set }
    var workingHours: String? { get set }
    var subcategories: [any SubcategoryRepresentable] { get set }
    
    func getPlaceholder() -> Placeholder
}
