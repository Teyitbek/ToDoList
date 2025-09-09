import Foundation

public protocol TodoRepresentable: Sendable {
    var todo: String? { get set }
    var subtitle: String? { get set }
    var id: Int64 { get set }
    var completed: Bool { get set }
    var userId: Int64 { get set }
}
