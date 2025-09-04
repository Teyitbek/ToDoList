import Foundation

public final class Session: SessionProtocol {
    public var userDetails: (name: String, id: String, notificationIsOn: Bool) {
        return (name: "", id: "", notificationIsOn: false)
    }
    
    public var profile: Profile? {
//        Defaults[.profile]
        Profile(name: "", profilePhotoUrl: "")
    }
    
    public var isAuthorized: Bool {
        return !getToken().isEmpty
    }
    
    public init() {}
    
    public func getToken() -> String {
//        return Defaults[.credentials].token
        return ""
    }
    
    public func save(profile: Profile) {
//        Defaults[.profile] = profile
    }
    
    public func resetToken() {
//        Defaults.reset(.credentials)
    }
    
    public func resetAll() {
    }
}
