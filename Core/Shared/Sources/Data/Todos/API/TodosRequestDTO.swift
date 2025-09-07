import Domain
import Extensions
import RealHTTP

struct TodosRequestDTO: Encodable, APIResourceConvertible {
    typealias Result = TodosGenericResponse<[TodosDTO]>
    
    func request() -> HTTPRequest {
        HTTPRequest {
            $0.path = "https://dummyjson.com/todos"
            $0.maxRetries = 3
            $0.method = .get
        }
    }
}
