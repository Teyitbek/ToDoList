import Foundation

public struct Secret: Sendable {
    public let location: String
    public let secret: String
    public let orderId: Int
    public let paymentIntentId: String
    public let paymentIntentSecret: String
    public let clientSecret: String
    public let publishableKey: String
    public let merchant: String
    
    public init(location: String, secret: String, orderId: Int, paymentIntentId: String, paymentIntentSecret: String, clientSecret: String, publishableKey: String, merchant: String) {
        self.location = location
        self.secret = secret
        self.orderId = orderId
        self.paymentIntentId = paymentIntentId
        self.paymentIntentSecret = paymentIntentSecret
        self.clientSecret = clientSecret
        self.publishableKey = publishableKey
        self.merchant = merchant
    }
}
