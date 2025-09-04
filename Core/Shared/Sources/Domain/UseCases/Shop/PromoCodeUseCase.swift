import Foundation

public protocol PromoCodeUseCase {
    func execute(with promoCode: String) async throws -> (cart: Cart, message:  String?)
}
