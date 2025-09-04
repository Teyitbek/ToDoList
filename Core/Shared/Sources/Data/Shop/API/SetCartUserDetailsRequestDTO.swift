import Extensions
import Domain
import RealHTTP

struct SetCartUserDetailsRequestDTO: Encodable, APIResourceConvertible {
    typealias Result = GenericResponse<CartDTO>
    let name: String
    let email: String?
    
    func request() -> HTTPRequest {
        HTTPRequest {
            $0.path = "/shop/set-user-details"
            $0.maxRetries = 3
            $0.method = .post
            $0.body = .json(self, encoder: .snakeCaseEncoder())
        }
    }
}
