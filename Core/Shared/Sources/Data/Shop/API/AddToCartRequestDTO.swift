import Domain
import Extensions
import Foundation
import RealHTTP

struct AddToCartRequestDTO: Encodable, APIResourceConvertible {
    let variationId: Int
    let quantity: Int
    let makeItCombo: Bool
    let combos: SelectedCombosDTO?
    let customizationOptions: [CartCustomizationOptionRequestDTO]
    let rewardId: Int?
    
    typealias Result = GenericResponse<CartDTO>
    
    init(from product: CartProduct) {
        self.variationId = product.variationId
        self.quantity = product.quantity
        self.makeItCombo = product.makeItCombo
        
        if let combos = product.combos {
            self.combos = SelectedCombosDTO(drinkId: combos.drinkId, snackId: combos.snackId)
        } else {
            self.combos = nil
        }
        
        self.customizationOptions = product.customizationOptions.map { CartCustomizationOptionRequestDTO(from: $0) }
        self.rewardId = product.rewardId
    }
    
    func request() -> HTTPRequest {
        HTTPRequest {
            $0.path = "/shop/add-to-cart"
            $0.method = .post
            $0.maxRetries = 3
            $0.body = .json(self, encoder: .snakeCaseEncoder())
        }
    }
}

