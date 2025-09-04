import Foundation

public class CartQuantityUpdate {
    public var orderItemId: Int
    public var quantity: Int
    
    public init(orderItemId: Int, quantity: Int) {
        self.orderItemId = orderItemId
        self.quantity = quantity
    }
}
