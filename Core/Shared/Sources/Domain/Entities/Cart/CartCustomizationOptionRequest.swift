import Foundation

public class CartCustomizationOptionRequest: CartCustomizationOptionRepresentable, CustomStringConvertible {
    public var id: Int
    public var items: [any CartCustomizationOptionItemRepresentable]
    
    public init(id: Int, items: [CartCustomizationOptionItem]) {
        self.id = id
        self.items = items
    }
    
    public var description: String {
        return "CartCustomizationOption(id: \(id), items: \(items))"
    }
}
