import Domain
import Foundation

public struct GroupedPricingDTO: Codable, DomainMappable {
    public var amountOfFreeQuantity: Int
    public var price: Float
    
    public init(amountOfFreeQuantity: Int, price: Float) {
        self.amountOfFreeQuantity = amountOfFreeQuantity
        self.price = price
    }
    
    public func toDomain() -> GroupedPricing {
        GroupedPricing(amountOfFreeQuantity: self.amountOfFreeQuantity, price: self.price)
    }
}
