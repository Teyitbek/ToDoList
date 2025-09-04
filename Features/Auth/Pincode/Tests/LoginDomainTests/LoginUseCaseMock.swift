import Domain
import PincodeDomain
import Foundation
import XCTest

class MockLoginRepository: PincodeRepository {
    var shouldSucceed = true
    
    func appleSignIn() async throws -> String {
        if shouldSucceed {
            "token"
        } else {
            throw NSError(domain: "AuthError", code: 401, userInfo: nil)
        }
    }
    
    func googleSignIn(idToken: String, accessToken: String) async throws -> String {
        if shouldSucceed {
            "token"
        } else {
            throw NSError(domain: "AuthError", code: 401, userInfo: nil)
        }
    }
    
    func login(with credentials: any Domain.Authenticatable & Domain.Emailable) async throws -> any UserInfoRepresentable {
        if shouldSucceed {
            UserInfo(accessToken: "token", user: User(email: "dummy@gmail.com", registrationCompleted: false, notifyEmailUpdates: false))
        } else {
            throw NSError(domain: "AuthError", code: 401, userInfo: nil)
        }
    }
    
    func loginProvider(token: String) async throws -> any Domain.UserInfoRepresentable {
        if shouldSucceed {
            UserInfo(accessToken: "token", user: User(email: "dummy@gmail.com", registrationCompleted: false, notifyEmailUpdates: false))
        } else {
            throw NSError(domain: "AuthError", code: 401, userInfo: nil)
        }
    }
}
