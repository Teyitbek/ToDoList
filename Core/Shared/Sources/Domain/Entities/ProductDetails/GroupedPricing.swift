import Foundation

public class GroupedPricing {
    public var amountOfFreeQuantity: Int
    public var price: Float
    
    public init(amountOfFreeQuantity: Int, price: Float) {
        self.amountOfFreeQuantity = amountOfFreeQuantity
        self.price = price
    }
}

extension GroupedPricing: NSCopying {
    public func copy(with zone: NSZone? = nil) -> Any {
        let copy = GroupedPricing(amountOfFreeQuantity: amountOfFreeQuantity, price: price)
        return copy
    }
}
