import Foundation

public struct DeviceSecret: Sendable {
    public let location: String
    public let secret: String
    
    public init(location: String, secret: String) {
        self.location = location
        self.secret = secret
    }
}
