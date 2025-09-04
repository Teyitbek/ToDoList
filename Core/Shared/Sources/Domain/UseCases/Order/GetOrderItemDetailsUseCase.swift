import Foundation

public protocol GetOrderItemDetailsUseCase {
    func execute(with id: Int) async throws -> ProductDetails
}
