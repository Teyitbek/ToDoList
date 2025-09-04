import Foundation

public protocol CartProductRepresentable {
    var variationId: Int { get set }
    var quantity: Int { get set }
    var makeItCombo: Bool { get set }
    var combos: SelectedCombos? { get set }
    var customizationOptions: [CartCustomizationOptionRepresentable] { get set }
}
