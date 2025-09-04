import Domain
import Foundation

public struct CombosDTO: Codable, DomainMappable {
    public let drinks: [ComboItemDTO]
    public let snacks: [ComboItemDTO]
    
    public init(drinks: [ComboItemDTO], snacks: [ComboItemDTO]) {
        self.drinks = drinks
        self.snacks = snacks
    }
    
    public init(from combos: CombosEntity) {
        self.drinks = combos.drinks.map { ComboItemDTO(id: $0.id, inventory: $0.inventory, type: $0.type, price: $0.price, selected: $0.selected) }
        self.snacks = combos.snacks.map { ComboItemDTO(id: $0.id, inventory: $0.inventory, type: $0.type, price: $0.price, selected: $0.selected) }
    }
    
    public func toDomain() -> CombosEntity {
        CombosEntity(drinks: self.drinks.map{ $0.toDomain() }, snacks: self.snacks.map { $0.toDomain() } )
    }
}

public struct ComboItemDTO: Codable, DomainMappable {
    public let id: Int
    public let inventory: String
    public let type: String
    public let price: Float
    public let selected: Bool
    
    public init(id: Int, inventory: String, type: String, price: Float, selected: Bool) {
        self.id = id
        self.inventory = inventory
        self.type = type
        self.price = price
        self.selected = selected
    }
    
    public func toDomain() -> ComboItem {
        ComboItem(id: id,
                  inventory: inventory,
                  type: type,
                  price: price,
                  selected: selected)
    }
}
