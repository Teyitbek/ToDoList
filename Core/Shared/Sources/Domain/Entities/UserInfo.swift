public struct UserInfo: UserInfoRepresentable {
    public var accessToken: String
    public var data: UserRepresentable
    
    public init(accessToken: String, data: UserRepresentable) {
        self.accessToken = accessToken
        self.data = data
    }
}
