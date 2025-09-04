import Foundation

public struct User: UserRepresentable {
    public var id: Int
    public var name: String?
    public var email: String
    public var role: String?
    public var contactDetails: String?
    public var active: Bool
    public var location: UserLocationable?
    
    public init(id: Int, name: String? = nil, email: String, role: String? = nil, contactDetails: String? = nil, active: Bool, location: UserLocationable? = nil) {
        self.id = id
        self.name = name
        self.email = email
        self.role = role
        self.contactDetails = contactDetails
        self.active = active
        self.location = location
    }
    
    public func getRole() -> UserRole {
        guard let role = role, let userRole = UserRole(rawValue: role) else { return .kitchen }
        return userRole
    }
}
