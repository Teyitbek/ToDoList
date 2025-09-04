import Domain

public struct RewardDetailsDTO: Codable, DomainMappable {
    public var id: Int
    public var title: String
    public var points: Int
    public var upTo: Float
    public var image: String?
    public var products: [ProductsDTO]?
    
    public init(id: Int,
                title: String,
                points: Int,
                upTo: Float,
                image: String? = nil,
                products: [ProductsDTO]? = nil) {
        self.id = id
        self.title = title
        self.points = points
        self.upTo = upTo
        self.image = image
        self.products = products
    }
    
    public init(from details: RewardDetails) {
        self.id = details.id
        self.title = details.title
        self.points = details.points
        self.upTo = details.upTo
        self.image = details.image
        
        if let products = details.products {
            self.products = products.map { ProductsDTO(from: $0) }
        } else {
            products = nil
        }
    }
    
    public func toDomain() -> RewardDetails {
        RewardDetails(id: id,
                      title: title,
                      points: points,
                      upTo: upTo,
                      image: image,
                      products: products?.map({ $0.toDomain() }) )
    }
}
