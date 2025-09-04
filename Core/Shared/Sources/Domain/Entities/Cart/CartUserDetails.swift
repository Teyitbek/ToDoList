import Foundation

public class CartUserDetails {
    public var name: String
    public var email: String?
    
    public init(name: String, email: String? = nil) {
        self.name = name
        self.email = email
    }
}
