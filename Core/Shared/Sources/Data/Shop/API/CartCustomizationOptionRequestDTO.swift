import Domain
import Foundation

struct CartCustomizationOptionRequestDTO: Encodable, DomainMappable {
    let id: Int
    let items: [CartCustomizationOptionItemRequestDTO]
    
    init(id: Int, items: [CartCustomizationOptionItemRequestDTO]) {
        self.id = id
        self.items = items
    }
    
    init(from customizationOption: CartCustomizationOptionRepresentable) {
        self.id = customizationOption.id
        self.items = customizationOption.items.map { CartCustomizationOptionItemRequestDTO(from: $0) }
    }
    
    func toDomain() -> CartCustomizationOptionRequest {
        CartCustomizationOptionRequest(id: self.id, items: self.items.map { $0.toDomain() })
    }
}
