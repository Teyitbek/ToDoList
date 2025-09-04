import Extensions
import RealHTTP

struct GetOrderItemDetailsRequestDTO: Encodable, APIResourceConvertible {
    let id: Int
    
    typealias Result = GenericResponse<ProductDetailsDTO>
    
    func request() -> HTTPRequest {
        HTTPRequest {
            $0.path = "/shop/cart/\(id)"
            $0.method = .get
            $0.maxRetries = 3
        }
    }
}
