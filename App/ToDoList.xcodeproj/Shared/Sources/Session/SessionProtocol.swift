import Foundation

public protocol SessionProtocol {
    var userDetails: (name: String, id: String, notificationIsOn: Bool) { get }
    var profile: Profile? { get }
    var isAuthorized: Bool { get }
    func save(profile: Profile)
    func getToken() -> String
    func resetToken()
    func resetAll()
}
