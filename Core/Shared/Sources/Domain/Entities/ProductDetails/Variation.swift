import Foundation

// MARK: - Variation
public class Variation {
    public var variationId: Int
    public var name: String
    public var price: Float
    public var protein: Int?
    public var calories: Int
    public var customizationOptions: [CustomizationOption]
    public var selected: Bool
    public var customizedPrice: Float
    public var priceForCombo: Float?
    public var boostMultiplier: Int?

    public init(
        variationId: Int,
        name: String,
        price: Float,
        protein: Int?,
        calories: Int,
        customizationOptions: [CustomizationOption],
        selected: Bool,
        customizedPrice: Float,
        priceForCombo: Float?,
        boostMultiplier: Int?
    ) {
        self.variationId = variationId
        self.name = name
        self.price = price
        self.protein = protein
        self.calories = calories
        self.customizationOptions = customizationOptions
        self.selected = selected
        self.customizedPrice = customizedPrice
        self.priceForCombo = priceForCombo
        self.boostMultiplier = boostMultiplier
    }
    
    public init() {
        self.variationId = 0
        self.name = ""
        self.price = 0
        self.protein = 0
        self.calories = 0
        self.customizationOptions = []
        self.selected = false
        self.customizedPrice = 0
        self.priceForCombo = nil
        self.boostMultiplier = nil
    }
    
    public func customizationOptionItem(for section: Int, row: Int) -> OptionItem {
        let item = customizationOptions[section].options[row]
        return item
    }
    
    public func customizationOption(for section: Int) -> CustomizationOption {
        let option = customizationOptions[section]
        return option
    }
    
    public func requiredSectionsAreFilled() -> Bool {
        let requiredCustomizationOptions = customizationOptions.filter { $0.required }
     
        let selectedRequiredCustomizationOptions = customizationOptions.filter { $0.options.contains(where: { $0.selected || $0.quantity > 0 }) && $0.required }
        
        let result = requiredCustomizationOptions.count == selectedRequiredCustomizationOptions.count
        
        return result
    }
    
    public func calculateCustomizedPrice() {
        for customizationOption in customizationOptions.filter({ $0.selected }) {
            if let groupedPricing = customizationOption.groupedPricing {
                guard customizationOption.options.filter({ $0.selected }).count > groupedPricing.amountOfFreeQuantity else { continue }
                customizedPrice += groupedPricing.price * Float(customizationOption.options.filter({ $0.selected }).count - groupedPricing.amountOfFreeQuantity)
            } else {
                for option in customizationOption.options {
                    guard option.quantity > option.amountOfFreeQuantity else { continue }
                    customizedPrice += option.price * Float(option.quantity - option.amountOfFreeQuantity)
                }
            }
        }
    }
}

extension Variation: NSCopying {
    public func copy(with zone: NSZone? = nil) -> Any {
        let copy = Variation(
            variationId: variationId,
            name: name,
            price: price,
            protein: protein,
            calories: calories,
            customizationOptions: customizationOptions.map { $0.copy() as! CustomizationOption },
            selected: selected,
            customizedPrice: customizedPrice,
            priceForCombo: priceForCombo,
            boostMultiplier: boostMultiplier
        )
        return copy
    }
}

extension Variation: CustomDebugStringConvertible {
    public var debugDescription: String {
        let desc = """
        Variation(
            variationId: \(variationId),
            name: \(name),
            price: \(price),
            protein: \(protein?.description ?? "nil"),
            calories: \(calories),
            customizationOptions: \(customizationOptions),
            selected: \(selected),
            customizedPrice: \(customizedPrice),
            priceForCombo: \(priceForCombo?.description ?? "nil"),
            boostMultiplier: \(boostMultiplier?.description ?? "nil")
        )
        """
        return desc
    }
}
