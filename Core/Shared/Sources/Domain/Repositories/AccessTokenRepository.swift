import Foundation

public protocol AccessTokenRepository {
    func save(accessToken: Tokenizable) throws
    func getAccessToken() throws -> Tokenizable?
    func deleteToken() throws
}
