import Foundation

public protocol CartCustomizationOptionRepresentable {
    var id: Int { get set }
    var items: [CartCustomizationOptionItemRepresentable] { get set }
}

public protocol CartCustomizationOptionItemRepresentable {
    var id: Int  { get set }
    var quantity: Int  { get set }
}
