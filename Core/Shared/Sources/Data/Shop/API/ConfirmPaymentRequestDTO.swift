import Foundation
import Extensions
import RealHTTP

struct ConfirmPaymentRequestDTO: Encodable, APIResourceConvertible {
    let orderId: Int
    let method: String
    
    typealias Result = GenericResponse<ConfirmedPaymentDTO>
    
    func request() -> HTTPRequest {
        HTTPRequest {
            $0.path = "/shop/confirm/\(orderId)"
            $0.method = .post
            $0.maxRetries = 3
            $0.body = .json(Method(method: method), encoder: .snakeCaseEncoder())
        }
    }
    
    struct Method: Encodable {
        var method: String
    }
}

