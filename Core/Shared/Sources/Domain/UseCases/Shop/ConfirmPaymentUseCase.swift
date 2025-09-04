import Foundation

public protocol ConfirmPaymentUseCase {
    func execute(orderId: Int, method: String) async throws -> ConfirmedPayment
}
