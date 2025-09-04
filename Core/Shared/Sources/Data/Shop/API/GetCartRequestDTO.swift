import Extensions
import RealHTTP

struct GetCartRequestDTO: Encodable, APIResourceConvertible {
    typealias Result = GenericResponse<CartDTO>
    
    func request() -> HTTPRequest {
        HTTPRequest {
            $0.path = "/shop/cart"
            $0.maxRetries = 3
            $0.addQueryParameter(name: "checkout", value: "")
            $0.method = .get
        }
    }
}
