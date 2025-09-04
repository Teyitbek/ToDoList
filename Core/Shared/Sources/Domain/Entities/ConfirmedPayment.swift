import Foundation

public struct ConfirmedPayment: Sendable {
    public let orderId: Int
    public let reward: Int?
    public let orderNumber: String
    
    public init(orderId: Int, reward: Int?, orderNumber: String) {
        self.orderId = orderId
        self.reward = reward
        self.orderNumber = orderNumber
    }
}
