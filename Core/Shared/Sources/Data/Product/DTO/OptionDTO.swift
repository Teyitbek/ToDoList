import Domain
import Foundation

public struct OptionDTO: Codable, DomainMappable {
    public var id: Int
    public var name: String
    public var price: Float
    public var amountOfFreeQuantity: Int
    public var selected: Bool
    public var quantity: Int
    public var removable: Bool?
    public var note: String?
    public var inStock: Bool

    public init(id: Int, name: String, price: Float, amountOfFreeQuantity: Int, selected: Bool, quantity: Int, removable: Bool?, note: String?, inStock: Bool) {
        self.id = id
        self.name = name
        self.price = price
        self.amountOfFreeQuantity = amountOfFreeQuantity
        self.selected = selected
        self.quantity = quantity
        self.removable = removable
        self.note = note
        self.inStock = inStock
    }
    
    public init(from option: OptionItem) {
        self.id = option.id
        self.name = option.name
        self.price = option.price
        self.amountOfFreeQuantity = option.amountOfFreeQuantity
        self.selected = option.selected
        self.quantity = option.quantity
        self.removable = option.removable
        self.note = option.note
        self.inStock = option.inStock
    }
    
    public func toDomain() -> OptionItem {
        OptionItem(id: self.id,
                   name: self.name,
                   price: self.price,
                   amountOfFreeQuantity: self.amountOfFreeQuantity,
                   selected: self.selected,
                   quantity: self.quantity,
                   removable: self.removable,
                   note: self.note,
                   inStock: self.inStock)
    }
}

