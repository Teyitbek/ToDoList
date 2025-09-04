import Foundation

public struct AccessToken: Tokenizable {
    public var accessToken: String
    
    public init(accessToken: String) {
        self.accessToken = accessToken
    }
}
