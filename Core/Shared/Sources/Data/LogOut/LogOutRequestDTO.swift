import Extensions
import RealHTTP

struct LogOutRequestDTO: Encodable, APIResourceConvertible {
    typealias Result = LogOutResponseDTO
    
    func request() -> HTTPRequest {
        HTTPRequest {
            $0.path = "/auth/logout"
            $0.maxRetries = 3
            $0.method = .post
        }
    }
}
