import Domain
import Foundation

public protocol ShopDataSource {
    func addToCart(product: CartProduct) async throws -> (cart: Cart, message:  String?)
    func updateQuantity(with quantity: CartQuantityUpdate) async throws -> (cart: Cart, message:  String?)
    func getCart() async throws -> Cart
    func clearCart() async throws -> Cart
    func getSecret() async throws -> Secret
    func getDeviceSecret() async throws -> DeviceSecret
    func confirm(orderId: Int, method: String) async throws -> ConfirmedPayment
    func setNotes(with notes: String) async throws -> (cart: Cart, message:  String?)
    func setPromoCode(with promoCode: String) async throws -> (cart: Cart, message:  String?)
    func payWithPoints() async throws -> String?
    func set(userDetails: CartUserDetails) async throws -> Cart
}
