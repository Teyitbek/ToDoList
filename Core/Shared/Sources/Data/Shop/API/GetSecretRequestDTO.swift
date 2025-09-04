import Foundation
import RealHTTP
import Extensions

struct GetSecretRequestDTO: Encodable, APIResourceConvertible {
    typealias Result = GenericResponse<SecretDTO>
    
    func request() -> HTTPRequest {
        HTTPRequest {
            $0.path = "/shop/get-secret"
            $0.method = .post
            $0.maxRetries = 3
        }
    }
}
