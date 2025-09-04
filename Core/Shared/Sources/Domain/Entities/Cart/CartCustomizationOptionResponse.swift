import Foundation

public class CartCustomizationOptionResponse: CartCustomizationOptionResponseRepresentable, CustomStringConvertible {
    public var id: Int
    public var name: String
    public var quantity: Int
    
    public init(id: Int, name: String, quantity: Int) {
        self.id = id
        self.name = name
        self.quantity = quantity
    }
    
    public var description: String {
        return "CartCustomizationOption(id: \(id), name: \(name)), quantity: \(quantity)"
    }
}
