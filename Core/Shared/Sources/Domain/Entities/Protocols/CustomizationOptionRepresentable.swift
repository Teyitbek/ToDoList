import Foundation

public protocol CustomizationOptionRepresentable {
    var name: String { get set }
    var required: Bool { get set }
    var allowMultiple: Bool { get set }
    var options: [IngredientRepresentable] { get set }
    var amountOfFreeQuantity: Int { get set }
}
