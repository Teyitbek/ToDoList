import Foundation

public protocol LocationsRepresentable {
    associatedtype Element
    var data: [Element] { get set }
    var message: String? { get set }
}
