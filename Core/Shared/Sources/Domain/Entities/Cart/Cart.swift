import Foundation

@preconcurrency
public class Cart  {
    public var orderId: Int
    public var orderNumber: String
    public var subTotalPrice: Float
    public var discount: Float
    public var taxes: Float
    public var totalPrice: Float
    public var totalItems: Int
    public var notes: String?
    public var promoCode: String?
    public var status: String
    public var totalPoints: Int
    public var totalCustomizationsPrice: Float
    public var reward: Int
    public var items: [CartItem]
    public var approximateReadyIn: String?
    public var scheduleOptions: [String]
    public var customerName: String?

    public init(orderId: Int, orderNumber: String, subTotalPrice: Float, discount: Float, taxes: Float, totalPrice: Float, totalItems: Int, notes: String?, promoCode: String?, status: String, totalPoints: Int, totalCustomizationsPrice: Float, reward: Int, items: [CartItem], approximateReadyIn: String?, scheduleOptions: [String], customerName: String?) {
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
    
    public init() {
        self.orderId = 0
        self.orderNumber = ""
        self.subTotalPrice = 0.0
        self.discount = 0
        self.taxes = 0
        self.totalPrice = 0.0
        self.totalItems = 0
        self.notes = nil
        self.promoCode = nil
        self.status = ""
        self.totalPoints = 0
        self.totalCustomizationsPrice = 0.0
        self.reward = 0
        self.items = []
        self.approximateReadyIn = nil
        self.scheduleOptions = []
    }
}
