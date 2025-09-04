import Foundation

public class ComboItem: @unchecked Sendable {
    public var id: Int
    public var inventory: String
    public var type: String
    public var price: Float
    public var selected: Bool
    
    public init(id: Int, inventory: String, type: String, price: Float, selected: Bool) {
        self.id = id
        self.inventory = inventory
        self.type = type
        self.price = price
        self.selected = selected
    }
}

extension ComboItem: NSCopying {
    public func copy(with zone: NSZone? = nil) -> Any {
        let copy = ComboItem(id: id, inventory: inventory, type: type, price: price, selected: selected)
        return copy
    }
}
