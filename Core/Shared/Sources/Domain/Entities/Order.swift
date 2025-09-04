import Foundation

public class Order {
    public let status: String
    public let title: String
    public let description: String
    public let id: Int
    public let storeName: String
    public let orderNumber: String
    public var selected: Bool
    public var readyBy: String
    
    public init(status: String, title: String, description: String, id: Int, locationName: String, orderNumber: String, selected: Bool, readyBy: String) {
        self.status = status
        self.title = title
        self.description = description
        self.id = id
        self.storeName = locationName
        self.orderNumber = orderNumber
        self.selected = selected
        self.readyBy = readyBy
    }
    
    public func getStatus() -> OrderStatus {
        guard let status = OrderStatus(rawValue: status) else { return .accepted }
        return status
    }
}
