import Extensions
import Foundation
import RealHTTP

struct ClearCartRequestDTO: Encodable, APIResourceConvertible {
    typealias Result = GenericResponse<CartDTO>
    
    func request() -> HTTPRequest {
        HTTPRequest {
            $0.path = "/shop/clear-cart"
            $0.method = .post
            $0.maxRetries = 3
        }
    }
}
