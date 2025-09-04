import Domain
import Extensions
import RealHTTP

struct PostOrderItemDetailsRequestDTO: Encodable, APIResourceConvertible {
    let id: Int
    let details: AddToCartRequestDTO
    
    typealias Result = GenericResponse<CartDTO>
    
    func request() -> HTTPRequest {
        HTTPRequest {
            $0.path = "/shop/cart/\(id)"
            $0.method = .post
            $0.maxRetries = 3
            $0.body = .json(details, encoder: .snakeCaseEncoder())
        }
    }
}
