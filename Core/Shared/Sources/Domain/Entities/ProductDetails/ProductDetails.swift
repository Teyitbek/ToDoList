import Foundation

@preconcurrency
public class ProductDetails {
    public var id: Int
    public var name: String
    public var description: String
    public var image: String?
    public var readyProduct: Bool
    public var isFavorite: Bool
    public var hasVariations: Bool
    public var variations: [Variation]
    public var combos: CombosEntity?
    public var rewardDetails: RewardDetails?
    public var placeholder: String
    public var quantity: Int
    
    public init(id: Int,
                name: String,
                description: String,
                image: String?,
                readyProduct: Bool,
                isFavorite: Bool,
                hasVariations: Bool,
                variations: [Variation],
                combos: CombosEntity?,
                rewardDetails: RewardDetails?,
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
    
    public init() {
        self.id = -1
        self.name = "Not available"
        self.description = "Not available"
        self.image = nil
        self.readyProduct = false
        self.isFavorite = false
        self.hasVariations = false
        self.variations = []
        self.combos = nil
        self.rewardDetails = nil
        self.placeholder = ""
        self.quantity = 1
    }
    
    /// This function checks if the selected variation's required customization options are filled.
    /// Required customization option must have at least one selected customization option item.
    public func isRequiredSectionsAreFilled() -> Bool {
        guard let selectedVariation = variations.first(where: { $0.selected }) else { return false }
        
        let requiredCustomizationOptionsCount = selectedVariation.customizationOptions.filter({ $0.required }).count
        let requiredCustomizationOptionsInTheSelectedCustomizationOptions = selectedVariation.customizationOptions.filter({ $0.options.filter({ $0.selected || $0.quantity > 0 }).count > 0 && $0.required }).count
        
        return requiredCustomizationOptionsCount == requiredCustomizationOptionsInTheSelectedCustomizationOptions
    }
    
    public func calculateCustomizedPriceForVariations() {
        variations.forEach({ $0.calculateCustomizedPrice() })
    }
    
    public func selectedVariation() -> Variation? {
        variations.first(where: { $0.selected })
    }
    
    public func preparePriceForCombo() {
        guard let combos = combos,
              let selectedVariation = variations.first(where: { $0.selected }),
                let comboPrice = selectedVariation.priceForCombo else { return }
        
        var selectedCombosPrice: Float = 0
        
        for option in combos.drinks.filter({ $0.selected }) {
            selectedCombosPrice += option.price
        }
        
        for option in combos.snacks.filter({ $0.selected }) {
            selectedCombosPrice += option.price
        }
        
        let basePrice = selectedVariation.price * Float(quantity)
        let comboPriceTotal = comboPrice * Float(quantity)
        let selectedCombosTotal = selectedCombosPrice * Float(quantity)
        let total = selectedVariation.customizedPrice - basePrice + comboPriceTotal + selectedCombosTotal

        selectedVariation.customizedPrice = total
    }
    
    public func isMakeItCombo() -> Bool {
        guard let combos else { return false }
        return !combos.drinks.filter { $0.selected == true }.isEmpty && !combos.snacks.filter { $0.selected == true }.isEmpty
    }
    
    public func getCombos() -> SelectedCombos? {
        guard let combos else { return nil }
        guard let selectedDrink = combos.drinks.first(where: { $0.selected }), let selectedSnack = combos.snacks.first(where: { $0.selected }) else { return nil }
        return SelectedCombos(drinkId: selectedDrink.id, snackId: selectedSnack.id)
    }
    
    public func getPlaceholder() -> Placeholder {
        guard let placeholder = Placeholder(rawValue: placeholder) else { return .other }
        return placeholder
    }
    
    public func makeProduct() -> Product? {
        guard let variation = variations.first else { return nil }
        return Product(id: id, name: name, image: image, price: variation.price, isFavorite: isFavorite, inStock: true, placeholder: placeholder)
    }
    
    public func makeCartProduct() -> CartProduct? {
        guard let variation = variations.first(where: { $0.selected }) else { return nil }
        
        let selectedCustomizationOptions = variation.customizationOptions
            .filter({ !$0.options.filter({ $0.quantity != 0 }).isEmpty })
            .map({ CartCustomizationOptionRequest(id: $0.id, items: $0.options
                .filter{ $0.quantity  != 0 }
                .map({ CartCustomizationOptionItem(id: $0.id, quantity: $0.quantity)}))})
        
        return CartProduct(variationId: variation.variationId,
                           quantity: quantity,
                           makeItCombo: isMakeItCombo(),
                           combos: getCombos(),
                           customizationOptions: selectedCustomizationOptions,
                           rewardId: rewardDetails?.id)
    }
}

extension ProductDetails: NSCopying {
    public func copy(with zone: NSZone? = nil) -> Any {
        let copy = ProductDetails(id: self.id,
                                  name: self.name,
                                  description: self.description,
                                  image: self.image,
                                  readyProduct: self.readyProduct,
                                  isFavorite: self.isFavorite,
                                  hasVariations: self.hasVariations,
                                  variations: self.variations.map{ $0.copy() as! Variation },
                                  combos: self.combos?.copy() as? CombosEntity,
                                  rewardDetails: self.rewardDetails?.copy() as? RewardDetails,
                                  placeholder: placeholder,
                                  quantity: self.quantity)
        return copy
    }
}
