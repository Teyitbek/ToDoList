import Foundation

public struct AppInit: Sendable {
    public let appName: String
    public let version: String
    public let keys: Keys
    
    public init(appName: String, version: String, keys: Keys) {
        self.appName = appName
        self.version = version
        self.keys = keys
    }
    
    public init() {
        self.appName = ""
        self.version = ""
        self.keys = .init(stripePublicKey: "")
    }
}

public struct Keys: Sendable {
    public let stripePublicKey: String
    
    public init(stripePublicKey: String) {
        self.stripePublicKey = stripePublicKey
    }
}
