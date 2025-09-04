import Foundation

public class CartCustomizationOptionItem: CartCustomizationOptionItemRepresentable, CustomStringConvertible {
    public var id: Int
    public var quantity: Int
    
    public init(id: Int, quantity: Int) {
        self.id = id
        self.quantity = quantity
    }
    
    public var description: String {
        return "CartCustomizationOptionItem(id: \(id), quantity: \(quantity))"
    }
}
