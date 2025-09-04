import Foundation

public protocol UserLocationable: Sendable {
    var id: Int { get }
    var name: String { get }
    var orderTimings: OrderTimingable? { get }
}

public protocol OrderTimingable: Sendable {
    var safeTime: Int { get }
    var approachingDeadline: Int { get }
    var urgent: Int { get }
}
