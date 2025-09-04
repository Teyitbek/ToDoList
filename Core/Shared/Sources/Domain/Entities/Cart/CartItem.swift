import Foundation

// MARK: - Item
public class CartItem {
    public var orderItemId: Int
    public var name: String
    public var description: String
    public var image: String?
    public var quantity: Int
    public var price: Float
    public var comboPrice: Float?
    public var totalPrice: Float
    public var combo: CartCombos?
    public var removedIngredients: [CartCustomizationOptionResponse]
    public var customizationOptions: [CartCustomizationOptionResponse]
    public var boostMultiplier: Int?
    public var points: Int?
    public var customizationsPrice: Float
    public var readyProduct: Bool
    public var placeholder: String

    public init(orderItemId: Int,
                name: String,
                description: String,
                image: String?,
                quantity: Int,
                price: Float,
                comboPrice: Float?,
                totalPrice: Float,
                combo: CartCombos?,
                removedIngredients: [CartCustomizationOptionResponse],
                customizationOptions: [CartCustomizationOptionResponse],
                boostMultiplier: Int?,
                points: Int? = nil,
                customizationsPrice: Float,
                readyProduct: Bool,
                placeholder: String) {
        self.orderItemId = orderItemId
        self.name = name
        self.description = description
        self.image = image
        self.quantity = quantity
        self.price = price
        self.comboPrice = comboPrice
        self.totalPrice = totalPrice
        self.combo = combo
        self.removedIngredients = removedIngredients
        self.customizationOptions = customizationOptions
        self.boostMultiplier = boostMultiplier
        self.points = points
        self.customizationsPrice = customizationsPrice
        self.readyProduct = readyProduct
        self.placeholder = placeholder
    }
    
    public init() {
        orderItemId = -1
        name = ""
        description = ""
        image = nil
        quantity = 0
        price = 0
        comboPrice = 0
        totalPrice = 0
        combo = nil
        removedIngredients = []
        customizationOptions = []
        readyProduct = false
        customizationsPrice = 0
        placeholder = ""
    }
    
    public func getDescription() -> String {
        if removedIngredients.isEmpty && customizationOptions.isEmpty && combo == nil && !readyProduct {
            return description
        } else {
            var descriptionText = ""
            
            for (index, removedIngredient) in removedIngredients.enumerated() {
                descriptionText += "No " + removedIngredient.name + (index != removedIngredients.count - 1 ? ", ": "\n")
            }
            
            if !customizationOptions.isEmpty {
                descriptionText += "+ "
                for (index, customizationOption) in customizationOptions.enumerated() {
                    descriptionText += customizationOption.name + (index != customizationOptions.count - 1 ? ", ": "\n")
                }
            }
            
            if let combo = combo {
                descriptionText += "Combo: "
                
                if let drink = combo.drink {
                    descriptionText += drink
                }
                
                if combo.drink != nil && combo.snack != nil {
                    descriptionText += " + "
                }
                
                if let snack = combo.snack {
                    descriptionText += snack
                }
            }
            
            return descriptionText
        }
    }
    
    public func getPlaceholder() -> Placeholder {
        guard let placeholder = Placeholder(rawValue: placeholder) else { return  .other }
        return placeholder
    }
}
