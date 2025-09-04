import Foundation

public enum OrderStatusType: String {
    case pending
    case scheduled
    case preparing
    case ready
    case cancelled
    case refunded
    case paid
    case completed
    case empty = ""
}
