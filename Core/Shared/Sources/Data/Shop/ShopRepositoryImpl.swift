import Domain

public struct ShopRepositoryImpl: ShopRepository {
    let dataSource: ShopDataSource
    
    public init(dataSource: ShopDataSource) {
        self.dataSource = dataSource
    }
    
    public func addToCart(product: CartProduct) async throws -> (cart: Cart, message:  String?) {
        try await dataSource.addToCart(product: product)
    }
    
    public func updateQuantity(with updateDetails: CartQuantityUpdate) async throws -> (cart: Cart, message:  String?) {
        try await dataSource.updateQuantity(with: updateDetails)
    }
    
    public func getCart() async throws -> Cart {
        try await dataSource.getCart()
    }
    
    public func clearCart() async throws -> Cart {
        try await dataSource.clearCart()
    }
    
    public func getSecret() async throws -> Secret {
        try await dataSource.getSecret()
    }
    
    public func getDeviceSecret() async throws -> DeviceSecret {
        try await dataSource.getDeviceSecret()
    }
    
    public func confirm(orderId: Int, method: String) async throws -> ConfirmedPayment {
        try await dataSource.confirm(orderId: orderId, method: method)
    }
    
    public func setNotes(with notes: String) async throws -> (cart: Cart, message:  String?) {
        try await dataSource.setNotes(with: notes)
    }
    
    public func setPromoCode(with promoCode: String) async throws -> (cart: Cart, message:  String?) {
        try await dataSource.setPromoCode(with: promoCode)
    }
    
    public func payWithPoints() async throws -> String? {
        try await dataSource.payWithPoints()
    }
    
    public func set(userDetails: CartUserDetails) async throws -> Cart {
        try await dataSource.set(userDetails: userDetails)
    }
}
