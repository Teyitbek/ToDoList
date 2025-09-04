import Domain
import Foundation

struct AppInitDTO: Decodable, DomainMappable {
    let appName: String
    let version: String
    let keys: KeysDTO
    
    func toDomain() -> AppInit {
        AppInit(appName: appName, version: version, keys: keys.toDomain())
    }
}

struct KeysDTO: Decodable, DomainMappable {
    let stripePublicKey: String
    
    func toDomain() -> Keys {
        Keys(stripePublicKey: stripePublicKey)
    }
}
