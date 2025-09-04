import Extensions
import RealHTTP

struct AccountIndexRequestDTO: Encodable, APIResourceConvertible {
    typealias Result = GenericResponse<UserDTO>
    
    func request() -> HTTPRequest {
        HTTPRequest {
            $0.path = "/account/info"
            $0.maxRetries = 3
            $0.method = .get
        }
    }
}
