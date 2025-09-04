import Foundation

public protocol UserRepresentable: Sendable {
    var id: Int { get set }
    var name: String? { get set }
    var email: String { get set }
    var role: String? { get set }
    var contactDetails: String? { get set }
    var active: Bool { get set }
    var location: UserLocationable? { get set }
    
    func getRole() -> UserRole
}
