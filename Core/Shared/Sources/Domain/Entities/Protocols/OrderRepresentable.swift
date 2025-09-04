import Foundation

public protocol OrderRepresentable: Sendable {
    var id: Int { get }
    var orderNumber: String { get }
    var orderSource: String { get }
    var userFullName: String? { get }
    var paymentDate: Int64? { get }
    var paymentDateFormatted: String? { get }
    var scheduleDate: Int64? { get }
    var scheduleDateFormatted: String? { get }
    var completedDate: Int64? { get }
    var completedDateFormatted: String? { get }
    var readyDate: Int64? { get }
    var readyDateFormatted: String? { get }
    var status: String { get set }
    var statusLabel: String { get }
    var notes: String? { get set }
    var items: [ProductRepresentable] { get set }
    var totalPrice: Float { get set }
    var totalRefundSum: Float? { get set }

    func getStatus() -> OrderStatusType
    func getCopy() -> Order
}
