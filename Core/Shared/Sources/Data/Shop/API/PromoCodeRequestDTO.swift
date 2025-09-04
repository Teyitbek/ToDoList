import Extensions
import RealHTTP

struct PromoCodeRequestDTO: Encodable, APIResourceConvertible {
    let code: String
    
    typealias Result = GenericResponse<CartDTO>
    
    public init(code: String) {
        self.code = code
    }
    
    func request() -> HTTPRequest {
        HTTPRequest {
            $0.path = "/shop/apply-promo-code"
            $0.method = .post
            $0.maxRetries = 3
            $0.body = .json(self, encoder: .snakeCaseEncoder())
        }
    }
}
