import Extensions
import Data
import RealHTTP

struct TodoRequestDTO: Encodable, APIResourceConvertible {
    typealias Result = GenericResponse<[TodoDTO]>
    
    func request() -> HTTPRequest {
        HTTPRequest {
            $0.path = "https://dummyjson.com/todos"
            $0.method = .get
            $0.maxRetries = 3
        }
    }
}
