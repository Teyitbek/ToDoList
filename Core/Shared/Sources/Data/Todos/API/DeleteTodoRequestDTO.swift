import Domain
import Extensions
import RealHTTP

struct DeleteTodoRequestDTO: Encodable, APIResourceConvertible {
    typealias Result = DeleteTodoResponse
    let id: Int
    
    func request() -> HTTPRequest {
        HTTPRequest {
            $0.path = "https://dummyjson.com/todos/\(id)"
            $0.maxRetries = 3
            $0.method = .delete
        }
    }
}
