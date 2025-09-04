import Domain
import Foundation

public class CartCombosDTO: Decodable, DomainMappable {
    public var drink: String?
    public var snack: String?
    
    public init(drink: String?, snack: String?) {
        self.drink = drink
        self.snack = snack
    }
    
    public func toDomain() -> CartCombos {
        CartCombos(drink: drink, snack: snack)
    }
}
