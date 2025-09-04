import Foundation

public struct ConfirmPaymentUseCaseImpl: ConfirmPaymentUseCase {
    private let repository: ShopRepository
    
    public init(repository: ShopRepository) {
        self.repository = repository
    }
    
    public func execute(orderId: Int, method: String) async throws -> ConfirmedPayment {
        try await repository.confirm(orderId: orderId, method: method)
    }
}
