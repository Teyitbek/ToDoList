import Data
import Extensions
import RealHTTP

struct LoginRequestDTO: Encodable, APIResourceConvertible {
    let pin: String
    
    typealias Result = LoginUserInfoDTO
    
    func request() -> HTTPRequest {
        HTTPRequest {
            $0.path = "/auth/login"
            $0.method = .post
            $0.maxRetries = 3
            $0.body = .json(self)
        }
    }
}
