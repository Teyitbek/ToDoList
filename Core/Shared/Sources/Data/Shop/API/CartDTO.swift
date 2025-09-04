import Domain
import Foundation

struct CartDTO: Decodable, DomainMappable {
    let orderId: Int
    let orderNumber: String
    let subTotalPrice: Float
    let discount: Float
    let taxes: Float
    let totalPrice: Float
    let totalItems: Int
    let notes: String?
    let promoCode: String?
    let status: String
    var totalPoints: Int
    var totalCustomizationsPrice: Float
    let reward: Int
    let items: [CartItemDTO]
    let approximateReadyIn: String?
    let scheduleOptions: [String]
    let customerName: String?
    
    init(orderId: Int, orderNumber: String, subTotalPrice: Float, discount: Float, taxes: Float, totalPrice: Float, totalItems: Int, notes: String?, promoCode: String?, status: String, totalPoints: Int, totalCustomizationsPrice: Float, reward: Int, items: [CartItemDTO], approximateReadyIn: String?, scheduleOptions: [String], customerName: String?) {
        self.orderId = orderId
        self.orderNumber = orderNumber
        self.subTotalPrice = subTotalPrice
        self.discount = discount
        self.taxes = taxes
        self.totalPrice = totalPrice
        self.totalItems = totalItems
        self.notes = notes
        self.promoCode = promoCode
        self.status = status
        self.totalPoints = totalPoints
        self.totalCustomizationsPrice = totalCustomizationsPrice
        self.reward = reward
        self.items = items
        self.approximateReadyIn = approximateReadyIn
        self.scheduleOptions = scheduleOptions
        self.customerName = customerName
    }
    
    func toDomain() -> Cart {
        Cart(orderId: self.orderId,
             orderNumber: self.orderNumber,
             subTotalPrice: self.subTotalPrice,
             discount: self.discount,
             taxes: self.taxes,
             totalPrice: self.totalPrice,
             totalItems: self.totalItems,
             notes: self.notes,
             promoCode: self.promoCode,
             status: self.status,
             totalPoints: self.totalPoints,
             totalCustomizationsPrice: self.totalCustomizationsPrice,
             reward: self.reward,
             items: self.items.map { $0.toDomain()},
             approximateReadyIn: approximateReadyIn,
             scheduleOptions: scheduleOptions,
             customerName: customerName)
    }
}

