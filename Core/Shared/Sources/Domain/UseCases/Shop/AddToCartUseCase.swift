import Foundation

public protocol AddToCartUseCase {
    func execute(with product: CartProduct) async throws -> (cart: Cart, message:  String?)
}
