import Foundation

public protocol CartCustomizationOptionResponseRepresentable {
    var id: Int { get set }
    var name: String { get set }
    var quantity: Int { get set }
}
