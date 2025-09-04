import Domain
import Foundation

public struct UserLocationDTO: Codable, DomainMappable {
    var id: Int
    var name: String
    var orderTimings: OrderTimingsDTO?
    
    public func toDomain() -> UserLocationable {
        UserLocation(id: id, name: name, orderTimings: orderTimings?.toDomain())
    }
    
    public init(from location: UserLocationable) {
        self.id = location.id
        self.name = location.name
        if let orderTimings = location.orderTimings {
            self.orderTimings = OrderTimingsDTO(from: orderTimings)
        }
    }
}

public struct OrderTimingsDTO: Codable, DomainMappable {
    var safeTime: Int
    var approachingDeadline: Int
    var urgent: Int
    
    public func toDomain() -> OrderTimingable {
        OrderTimings(safeTime: safeTime, approachingDeadline: approachingDeadline, urgent: urgent)
    }
    
    public init(from timing: OrderTimingable) {
        safeTime = timing.safeTime
        approachingDeadline = timing.approachingDeadline
        urgent = timing.urgent
    }
}
