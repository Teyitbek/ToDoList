import Foundation

public protocol TodoRepresentable: Sendable {
    var todo: String? { get set }
    var createdAt: Date? { get set }
    var id: Int64 { get set }
    var completed: Bool { get set }
    var userId: Int64 { get set }
    var uuid: UUID? { get set }
}
