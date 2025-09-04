import Extensions
import RealHTTP

struct PayWithPointsRequestDTO: Encodable, APIResourceConvertible {
    typealias Result = PayWithPointsResponseDTO
    
    func request() -> HTTPRequest {
        HTTPRequest {
            $0.path = "/shop/pay-with-points"
            $0.method = .post
            $0.maxRetries = 3
        }
    }
}
