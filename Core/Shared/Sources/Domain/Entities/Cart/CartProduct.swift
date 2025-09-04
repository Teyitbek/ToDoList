import Foundation

@preconcurrency
public class CartProduct: CartProductRepresentable, CustomStringConvertible {
    public var variationId: Int
    public var quantity: Int
    public var makeItCombo: Bool
    public var combos: SelectedCombos?
    public var customizationOptions: [any CartCustomizationOptionRepresentable]
    public var rewardId: Int?
    
    public init(variationId: Int, quantity: Int, makeItCombo: Bool = false, combos: SelectedCombos? = nil, customizationOptions: [CartCustomizationOptionRepresentable], rewardId: Int? = nil) {
        self.variationId = variationId
        self.quantity = quantity
        self.makeItCombo = makeItCombo
        self.combos = combos
        self.customizationOptions = customizationOptions
        self.rewardId = rewardId
    }
    
    public var description: String {
        return "CartProduct(variationId: \(variationId), quantity: \(quantity), makeItCombo: \(makeItCombo), combos: \(String(describing: combos)), customizationOptions: \(customizationOptions))"
    }
}

public class SelectedCombos {
    public var drinkId: Int
    public var snackId: Int
    
    public init(drinkId: Int, snackId: Int) {
        self.drinkId = drinkId
        self.snackId = snackId
    }
}
