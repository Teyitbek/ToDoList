import Domain
import StartDomain
import Data
import Foundation

struct BannerDTO: Decodable, DomainMappable {
    let path: String?
    
    func toDomain() -> BannerRepresentable {
        Banner(path: path)
    }
}
