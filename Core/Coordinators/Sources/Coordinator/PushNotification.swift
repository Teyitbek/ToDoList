struct PushNotification: Decodable {
    enum Kind: String, Decodable {
        case none
    }
    
    var type: Kind
    
    static func map(_ dict: [AnyHashable: Any]) -> Self? {
        guard let typeString = dict["type"] as? String,
              let notificationType = Kind(rawValue: typeString) else { return nil }
        return PushNotification(type: notificationType)
    }
}
