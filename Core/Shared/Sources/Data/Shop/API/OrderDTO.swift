import Domain
import Foundation

struct OrderDTO: Decodable, DomainMappable {
    let status: String
    let title: String
    let description: String
    let id: Int
    let locationName: String
    let orderNumber: String
    let readyBy: String
    
    func toDomain() -> Order {
        Order(status: status, title: title, description: description, id: id, locationName: locationName, orderNumber: orderNumber, selected: false, readyBy: readyBy)
    }
}
