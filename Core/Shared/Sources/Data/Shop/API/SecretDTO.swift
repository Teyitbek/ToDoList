import Domain

struct SecretDTO: Decodable, DomainMappable {
    let location: String
    let secret: String
    let orderId: Int
    let paymentIntentId: String
    let paymentIntentSecret: String
    let clientSecret: String
    let publishableKey: String
    let merchant: String
    
    func toDomain() -> Secret {
        Secret(location: location, secret: secret, orderId: orderId, paymentIntentId: paymentIntentId, paymentIntentSecret: paymentIntentSecret, clientSecret: clientSecret, publishableKey: publishableKey, merchant: merchant)
    }
}
