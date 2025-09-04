import Foundation

public class OptionItem {
    public var id: Int
    public var name: String
    public var price: Float
    public var amountOfFreeQuantity: Int
    public var selected: Bool
    public var quantity: Int
    public var removable: Bool?
    public var note: String?
    public var inStock: Bool
    

    public init(id: Int, name: String, price: Float, amountOfFreeQuantity: Int, selected: Bool, quantity: Int, removable: Bool? , note: String?, inStock: Bool) {
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
}

extension OptionItem: NSCopying {
    public func copy(with zone: NSZone? = nil) -> Any {
        let copy = OptionItem(id: id,
                              name: name,
                              price: price,
                              amountOfFreeQuantity: amountOfFreeQuantity,
                              selected: selected,
                              quantity: quantity,
                              removable: removable,
                              note: note,
                              inStock: inStock)
        return copy
    }
}
