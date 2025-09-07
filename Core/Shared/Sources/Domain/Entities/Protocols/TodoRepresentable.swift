import Foundation

public protocol TodoRepresentable: Sendable {
    var todo: String { get set }
    var id: Int { get set }
    var completed: Bool { get set }
    var userId: Int { get set }
}
