import Domain
import Foundation

struct CartCustomizationOptionItemRequestDTO: Encodable, DomainMappable {
    let id: Int
    let quantity: Int
    
    init(id: Int, quantity: Int) {
        self.id = id
        self.quantity = quantity
    }
    
    init(from customizationOptionItem: CartCustomizationOptionItemRepresentable) {
        self.id = customizationOptionItem.id
        self.quantity = customizationOptionItem.quantity
    }
    
    func toDomain() -> CartCustomizationOptionItem {
        CartCustomizationOptionItem(id: self.id, quantity: self.quantity)
    }
}
