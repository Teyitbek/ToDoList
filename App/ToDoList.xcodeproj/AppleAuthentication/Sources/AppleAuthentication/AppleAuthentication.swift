import AuthenticationServices

public typealias AppleCredentials = (nonce: String, idTokenString: String)

public enum AppleAuthenticationResult {
    case success(AppleCredentials)
    case failure(Error)
}

public protocol AppleAuthenticationDelegate: AnyObject {
    func appleAuthenticationManagerSucceeded(with result: AppleAuthenticationResult)
}

public final class AppleAuthenticationManager: NSObject {
    public weak var delegate: AppleAuthenticationDelegate?
    var currentNonce: String?
    
    public func signIn() throws {
        let request = try createAppleIdRequest()
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
    
    func createAppleIdRequest(with scopes: [ASAuthorization.Scope] = [.email, .fullName]) throws -> ASAuthorizationAppleIDRequest {
        let appleIdProvider = ASAuthorizationAppleIDProvider()
        let request = appleIdProvider.createRequest()
        request.requestedScopes = scopes
        
        let nonce = try NonceGenerator.generate()
        request.nonce = nonce
        currentNonce = nonce

        return request
    }
}

extension AppleAuthenticationManager: ASAuthorizationControllerDelegate {
    public func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            guard let nonce = currentNonce,
                  let appleIDToken = appleIDCredential.identityToken,
                  let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
                delegate?.appleAuthenticationManagerSucceeded(with: .failure(NSError(domain: "Something went wrong while getting apple credentials", code: 0)))
                return
            }
            delegate?.appleAuthenticationManagerSucceeded(with: .success((nonce, idTokenString)))
        } else {
            delegate?.appleAuthenticationManagerSucceeded(with: .failure(NSError(domain: "Could not cast credential to ASAuthorizationIDCredential", code: 1)))
        }
    }
}

extension AppleAuthenticationManager: ASAuthorizationControllerPresentationContextProviding {
    public func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        let scenes = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let window = scenes?.windows.last
        return window!
    }
    
    public func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        delegate?.appleAuthenticationManagerSucceeded(with: .failure(error))
    }
}
