import Domain

struct AccessTokenDTO: Tokenizable, Codable {
    var accessToken: String
}

extension AccessTokenDTO {
    func toDomain() -> Tokenizable {
        AccessToken(accessToken: self.accessToken)
    }
}
