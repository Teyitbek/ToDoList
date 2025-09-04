public struct PromoCodeUseCaseImpl: PromoCodeUseCase {
    private let repository: ShopRepository
    
    public init(repository: ShopRepository) {
        self.repository = repository
    }
    
    public func execute(with promoCode: String) async throws -> (cart: Cart, message:  String?) {
        try await repository.setPromoCode(with: promoCode)
    }
}
