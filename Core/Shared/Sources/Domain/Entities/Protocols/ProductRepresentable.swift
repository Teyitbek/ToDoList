import Foundation

public protocol ProductRepresentable: Sendable {
    var id: Int { get set }
    var name: String { get set }
    var image: String? { get set }
    var price: Float { get set }
    var isFavorite: Bool { get set }
    var boostMultiplier: Int? { get set }
    var variationId: Int? { get set }
    var inStock: Bool { get set }
    var placeholder: String { get set }
    
    func getPlaceholder() -> Placeholder
}
