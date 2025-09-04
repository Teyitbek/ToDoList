import Foundation

public class Product: ProductRepresentable {
    public var id: Int
    public var name: String
    public var image: String?
    public var price: Float
    public var isFavorite: Bool
    public var boostMultiplier: Int?
    public var variationId: Int?
    public var inStock: Bool
    public var placeholder: String
    
    public init(id: Int, name: String, image: String?, price: Float, isFavorite: Bool, boostMultiplier: Int? = nil, variationId: Int? = nil, inStock: Bool, placeholder: String) {
        self.id = id
        self.name = name
        self.image = image
        self.price = price
        self.isFavorite = isFavorite
        self.boostMultiplier = boostMultiplier
        self.variationId = variationId
        self.inStock = inStock
        self.placeholder = placeholder
    }
    
    public func getPlaceholder() -> Placeholder {
        guard let placeholder = Placeholder(rawValue: placeholder) else { return .other }
        return placeholder
    }
}
