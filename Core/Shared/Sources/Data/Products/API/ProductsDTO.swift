import Domain

public struct ProductsDTO: Codable, DomainMappable {
    public var id: Int
    public var name: String
    public var image: String?
    public var price: Float
    public var isFavorite: Bool
    public var boostMultiplier: Int?
    public var variationId: Int?
    public var inStock: Bool
    public var placeholder: String
    
    public init(from products: ProductRepresentable) {
        self.id = products.id
        self.name = products.name
        self.image = products.image
        self.price = products.price
        self.isFavorite = products.isFavorite
        self.boostMultiplier = products.boostMultiplier
        self.variationId = products.variationId
        self.inStock = products.inStock
        self.placeholder = products.placeholder
    }
    
    public func toDomain() -> ProductRepresentable {
        Product(id: self.id,
                name: self.name,
                image: self.image,
                price: self.price,
                isFavorite: self.isFavorite,
                boostMultiplier: self.boostMultiplier,
                variationId: self.variationId,
                inStock: self.inStock,
                placeholder: placeholder
        )
    }
}
