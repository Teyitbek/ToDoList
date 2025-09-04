import Foundation

public struct UserLocation: UserLocationable {
    public var id: Int
    public var name: String
    public var orderTimings: (any OrderTimingable)?
    
    public init(id: Int, name: String, orderTimings: (any OrderTimingable)? = nil) {
        self.id = id
        self.name = name
        self.orderTimings = orderTimings
    }
}

public struct OrderTimings: OrderTimingable {
    public let safeTime: Int
    public let approachingDeadline: Int
    public let urgent: Int
    
    public init(safeTime: Int, approachingDeadline: Int, urgent: Int) {
        self.safeTime = safeTime
        self.approachingDeadline = approachingDeadline
        self.urgent = urgent
    }
}
