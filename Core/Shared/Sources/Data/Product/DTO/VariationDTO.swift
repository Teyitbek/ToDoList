import Domain
import Foundation

// MARK: - Variation
public struct VariationDTO: Codable, DomainMappable {
    public var variationId: Int
    public var name: String
    public var price: Float
    public var protein: Int?
    public var calories: Int
    public var customizationOptions: [CustomizationOptionDTO]
    public var selected: Bool
    public var priceForCombo: Float?
    public var boostMultiplier: Int?

    public init(variationId: Int, name: String, price: Float, protein: Int?, calories: Int, customizationOptions: [CustomizationOptionDTO], selected: Bool, priceForCombo: Float?, boostMultiplier: Int?) {
        self.variationId = variationId
        self.name = name
        self.price = price
        self.protein = protein
        self.calories = calories
        self.customizationOptions = customizationOptions
        self.selected = selected
        self.priceForCombo = priceForCombo
        self.boostMultiplier = boostMultiplier
    }
    
    public init(from variation: Variation) {
        variationId = variation.variationId
        name = variation.name
        price = variation.price
        protein = variation.protein
        calories = variation.calories
        customizationOptions = variation.customizationOptions.map { CustomizationOptionDTO(from: $0) }
        selected = variation.selected
        priceForCombo = variation.priceForCombo
        boostMultiplier = variation.boostMultiplier
    }
    
    public func toDomain() -> Variation {
        Variation(variationId: self.variationId,
                  name: self.name,
                  price: self.price,
                  protein: self.protein,
                  calories: self.calories,
                  customizationOptions: self.customizationOptions.map { $0.toDomain() },
                  selected: self.selected,
                  customizedPrice: self.price,
                  priceForCombo: self.priceForCombo,
                  boostMultiplier: self.boostMultiplier)
    }
}
