import Domain
import Foundation

public struct ProductDetailsDTO: Codable, DomainMappable {
    public var id: Int
    public var name: String
    public var description: String
    public var image: String?
    public var readyProduct: Bool
    public var isFavorite: Bool
    public var hasVariations: Bool
    public var variations: [VariationDTO]
    public var combos: CombosDTO?
    public var rewardDetails: RewardDetailsDTO?
    public var placeholder: String
    public var quantity: Int

    public init(id: Int,
                name: String,
                description: String,
                image: String?,
                readyProduct: Bool,
                isFavorite: Bool,
                hasVariations: Bool,
                variations: [VariationDTO],
                combos: CombosDTO?,
                rewardDetails: RewardDetailsDTO?,
                placeholder: String,
                quantity: Int) {
        self.id = id
        self.name = name
        self.description = description
        self.image = image
        self.readyProduct = readyProduct
        self.isFavorite = isFavorite
        self.hasVariations = hasVariations
        self.variations = variations
        self.combos = combos
        self.rewardDetails = rewardDetails
        self.placeholder = placeholder
        self.quantity = quantity
    }
    
    public init(from details: ProductDetails) {
        id = details.id
        name = details.name
        description = details.description
        image = details.image
        readyProduct = details.readyProduct
        isFavorite = details.isFavorite
        hasVariations = details.hasVariations
        variations = details.variations.map { VariationDTO(from: $0) }
        
        if let combos = details.combos {
            self.combos = CombosDTO(from: combos)
        } else {
            self.combos = nil
        }
        
        if let rewardDetails = details.rewardDetails {
            self.rewardDetails = RewardDetailsDTO(from: rewardDetails)
        } else {
            rewardDetails = nil
        }
        
        placeholder = details.placeholder
        quantity = details.quantity
    }
    
    public func toDomain() -> ProductDetails {
        ProductDetails(id: id,
                       name: name,
                       description: description,
                       image: image,
                       readyProduct: readyProduct,
                       isFavorite: isFavorite,
                       hasVariations: hasVariations,
                       variations: variations.map { $0.toDomain() },
                       combos: combos?.toDomain(),
                       rewardDetails: rewardDetails?.toDomain(),
                       placeholder: placeholder,
                       quantity: quantity)
    }
}
