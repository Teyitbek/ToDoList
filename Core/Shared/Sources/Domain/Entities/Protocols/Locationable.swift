import Foundation

public protocol Locationable: Sendable {
    var id: Int { get }
    var name: String { get }
}
