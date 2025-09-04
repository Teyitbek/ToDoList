import Foundation

public struct OrderHistory: Sendable {
    public let id: Int
    public let orderNumber: String
    public let status: String
    public let completedAt: String
    public let itemsCount: Int
    public let totalPrice: Float
    
    public init(id: Int, orderNumber: String, status: String, completedAt: String, itemsCount: Int, totalPrice: Float) {
        self.id = id
        self.orderNumber = orderNumber
        self.status = status
        self.completedAt = completedAt
        self.itemsCount = itemsCount
        self.totalPrice = totalPrice
    }
}
