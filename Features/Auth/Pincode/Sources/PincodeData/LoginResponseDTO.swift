import Data
import Domain
import Foundation

struct LoginUserInfoDTO: Decodable, DomainMappable {
    let accessToken: String
    let data: UserDTO
    
    func toDomain() -> UserInfoRepresentable {
        UserInfo(accessToken: self.accessToken, data: self.data.toDomain())
    }
}
