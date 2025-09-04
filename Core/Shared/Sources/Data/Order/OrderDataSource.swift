import Domain
import Foundation

public protocol OrderDataSource {
    func getOrderItemDetails(with id: Int) async throws -> ProductDetails
    func postOrderItemDetails(with id: Int, details: CartProduct) async throws -> Cart
}
