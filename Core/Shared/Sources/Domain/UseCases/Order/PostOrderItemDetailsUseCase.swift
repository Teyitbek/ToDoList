import Foundation

public protocol PostOrderItemDetailsUseCase {
    func execute(with id: Int, details: CartProduct) async throws -> Cart
}

