import Extensions
import RealHTTP

struct CartQuantityUpdateDTO: Encodable, APIResourceConvertible {
    let orderItemId: Int
    let quantity: Int
    
    typealias Result = GenericResponse<CartDTO>
    
    public init(orderItemId: Int, quantity: Int) {
        self.orderItemId = orderItemId
        self.quantity = quantity
    }
    
    func request() -> HTTPRequest {
        HTTPRequest {
            $0.path = "/shop/update-qty"
            $0.method = .post
            $0.maxRetries = 3
            $0.body = .json(self, encoder: .snakeCaseEncoder())
        }
    }
}
