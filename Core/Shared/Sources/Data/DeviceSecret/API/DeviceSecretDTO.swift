import Domain

struct DeviceSecretDTO: Codable, DomainMappable {
    let location: String
    let secret: String
    
    func toDomain() -> DeviceSecret {
        DeviceSecret(location: location, secret: secret)
    }
}
