import Foundation

public class Ingredient: IngredientRepresentable {
    public var name: String
    public var quantity: Int
    
    public init(name: String, quantity: Int) {
        self.name = name
        self.quantity = quantity
    }
}
