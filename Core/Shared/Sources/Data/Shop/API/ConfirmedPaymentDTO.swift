import Foundation
import Domain

struct ConfirmedPaymentDTO: Decodable, DomainMappable {
    let orderId: Int
    let reward: Int?
    let orderNumber: String
    
    func toDomain() -> ConfirmedPayment {
        ConfirmedPayment(orderId: orderId, reward: reward, orderNumber: orderNumber)
    }
}
