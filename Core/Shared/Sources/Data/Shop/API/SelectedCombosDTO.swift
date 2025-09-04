import Domain
import Foundation

struct SelectedCombosDTO: Encodable, DomainMappable {
    let drinkId: Int
    let snackId: Int
    
    func toDomain() -> SelectedCombos {
        SelectedCombos(drinkId: self.drinkId, snackId: self.snackId)
    }
}
