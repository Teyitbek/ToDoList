import Foundation

public protocol UpdateQuantityUseCase {
    func execute(with quantity: CartQuantityUpdate) async throws -> (cart: Cart, message:  String?)
}
