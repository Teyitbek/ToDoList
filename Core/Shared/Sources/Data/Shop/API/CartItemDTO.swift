import Domain
import Foundation

// MARK: - Item
struct CartItemDTO: Decodable, DomainMappable {
    let orderItemId: Int
    let name: String
    let description: String
    let image: String?
    let quantity: Int
    let price: Float
    let comboPrice: Float?
    let totalPrice: Float
    let combo: CartCombosDTO?
    let removedIngredients: [CartCustomizationOptionResponseDTO]
    let customizationOptions: [CartCustomizationOptionResponseDTO]
    let boostMultiplier: Int?
    let points: Int?
    let customizationsPrice: Float
    let readyProduct: Bool
    let placeholder: String

    init(orderItemId: Int,
         name: String,
         description: String,
         image: String?,
         quantity: Int,
         price: Float,
         comboPrice: Float?,
         totalPrice: Float,
         combo: CartCombosDTO?,
         removedIngredients: [CartCustomizationOptionResponseDTO],
         customizationOptions: [CartCustomizationOptionResponseDTO],
         boostMultiplier: Int?,
         points: Int?,
         customizationsPrice: Float,
         readyProduct: Bool,
         placeholder: String) {
        self.orderItemId = orderItemId
        self.name = name
        self.description = description
        self.image = image
        self.quantity = quantity
        self.price = price
        self.comboPrice = comboPrice
        self.totalPrice = totalPrice
        self.combo = combo
        self.removedIngredients = removedIngredients
        self.customizationOptions = customizationOptions
        self.boostMultiplier = boostMultiplier
        self.points = points
        self.customizationsPrice = customizationsPrice
        self.readyProduct = readyProduct
        self.placeholder = placeholder
    }
    
    func toDomain() -> CartItem {
        CartItem(orderItemId: self.orderItemId,
                 name: self.name,
                 description: self.description,
                 image: self.image,
                 quantity: self.quantity,
                 price: self.price,
                 comboPrice: self.comboPrice,
                 totalPrice: self.totalPrice,
                 combo: self.combo?.toDomain(),
                 removedIngredients: self.removedIngredients.map { $0.toDomain() },
                 customizationOptions: self.customizationOptions.map { $0.toDomain() },
                 boostMultiplier: self.boostMultiplier,
                 points: self.points,
                 customizationsPrice: self.customizationsPrice,
                 readyProduct: self.readyProduct,
                 placeholder: placeholder)
    }
}
