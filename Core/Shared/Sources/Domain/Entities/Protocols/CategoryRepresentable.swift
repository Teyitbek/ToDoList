import Foundation

public protocol CategoryRepresentable: Sendable {
    var id: Int { get set }
    var name: String { get set }
}
