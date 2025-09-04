import Foundation
import LoginDomain

final class UserDefaultsTokenStorage {
    private var userDefaults: UserDefaults
    private let tokenKey = "token"
    
    init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }
}

extension UserDefaultsTokenStorage: TokenDataSource {
    func fetchToken() throws -> Token? {
        let decoder = JSONDecoder()
        if let encodedToken = userDefaults.value(forKey: tokenKey) as? Data {
            let decodedToken = try decoder.decode(TokenDTO.self, from: encodedToken)
            return Token(token: decodedToken.token)
        }
        return nil
    }
    
    func deleteToken() {
        userDefaults.removeObject(forKey: tokenKey)
    }
    
    func save(token: Token) throws {
        let encoder = JSONEncoder()
        let encodedToken = try encoder.encode(TokenDTO(token: token.token))
        userDefaults.set(encodedToken, forKey: tokenKey)
    }
}

struct TokenDTO: Codable {
    let token: String
}
