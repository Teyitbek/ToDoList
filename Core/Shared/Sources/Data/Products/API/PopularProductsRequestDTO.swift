import Domain
import Extensions
import RealHTTP

struct PopularProductsRequestDTO: Encodable, APIResourceConvertible {
    typealias Result = GenericResponse<[ProductsDTO]>
    
    func request() -> HTTPRequest {
        HTTPRequest {
            $0.path = "/products/recommended"
            $0.maxRetries = 3
            $0.method = .get
        }
    }
}
