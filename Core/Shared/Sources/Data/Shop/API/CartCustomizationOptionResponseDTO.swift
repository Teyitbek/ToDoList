import Domain
import Foundation

struct CartCustomizationOptionResponseDTO: Decodable, DomainMappable {
    let id: Int
    let name: String
    let quantity: Int
    
    init(id: Int, name: String, quantity: Int) {
        self.id = id
        self.name = name
        self.quantity = quantity
    }
    
    func toDomain() -> CartCustomizationOptionResponse {
        CartCustomizationOptionResponse(id: self.id, name: self.name, quantity: self.quantity)
    }
}
