import Foundation

public protocol SubcategoryRepresentable: Sendable, Equatable {
    var id: Int { get set }
    var name: String { get set }
}
