import Domain
import Foundation
import RealHTTP

public struct ShopRemoteDataSource: ShopDataSource {
    private let client: HTTPClient
    
    public init(client: HTTPClient) {
        self.client = client
    }
    
    public func addToCart(product: CartProduct) async throws -> (cart: Cart, message:  String?) {
        let response = try await client.fetch(AddToCartRequestDTO(from: product))
        return (response.data.toDomain(), response.message)
    }
    
    public func updateQuantity(with updateDetails: CartQuantityUpdate) async throws -> (cart: Cart, message:  String?) {
        let response = try await client.fetch(CartQuantityUpdateDTO(orderItemId: updateDetails.orderItemId, quantity: updateDetails.quantity))
        return (response.data.toDomain(), response.message)
    }
    
    public func getCart() async throws -> Cart {
        try await client.fetch(GetCartRequestDTO()).toDomain()
    }
    
    public func clearCart() async throws -> Cart {
        try await client.fetch(ClearCartRequestDTO()).toDomain()
    }
    
    public func getSecret() async throws -> Secret {
        try await client.fetch(GetSecretRequestDTO()).toDomain()
    }
    
    public func getDeviceSecret() async throws -> DeviceSecret {
        try await client.fetch(GetDeviceSecretRequestDTO()).toDomain()
    }
    
    public func confirm(orderId: Int, method: String) async throws -> ConfirmedPayment {
        try await client.fetch(ConfirmPaymentRequestDTO(orderId: orderId, method: method)).toDomain()
    }
    
    public func setNotes(with notes: String) async throws -> (cart: Cart, message:  String?) {
        let response = try await client.fetch(NotesRequestDTO(notes: notes))
        return (response.data.toDomain(), response.message)
    }
    
    public func setPromoCode(with promoCode: String) async throws -> (cart: Cart, message:  String?) {
        let response = try await client.fetch(PromoCodeRequestDTO(code: promoCode))
        return (response.data.toDomain(), response.message)
    }
    
    public func payWithPoints() async throws -> String? {
        try await client.fetch(PayWithPointsRequestDTO()).message
    }
    
    public func set(userDetails: CartUserDetails) async throws -> Cart {
        try await client.fetch(SetCartUserDetailsRequestDTO(name: userDetails.name, email: userDetails.email)).toDomain()
    }
}
