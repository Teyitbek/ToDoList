import Domain
import Foundation

public struct UserDTO: Codable, DomainMappable {
    var id: Int
    var name: String?
    var email: String
    var role: String?
    var contactDetails: String?
    var active: Bool
    var location: UserLocationDTO?
}

public extension UserDTO {
    init(from user: UserRepresentable) {
        self.id = user.id
        self.name = user.name
        self.email = user.email
        self.role = user.role
        self.contactDetails = user.contactDetails
        self.active = user.active
        if let location = user.location {
            self.location = UserLocationDTO(from: location)
        }
    }
}

public extension UserDTO {
    func toDomain() -> UserRepresentable {
        User(id: id, name: name, email: email, role: role, contactDetails: contactDetails, active: active, location: location?.toDomain())
    }
}
