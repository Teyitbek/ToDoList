import Extensions
import RealHTTP

struct NotesRequestDTO: Encodable, APIResourceConvertible {
    let notes: String
    
    typealias Result = GenericResponse<CartDTO>
    
    public init(notes: String) {
        self.notes = notes
    }
    
    func request() -> HTTPRequest {
        HTTPRequest {
            $0.path = "/shop/set-notes"
            $0.method = .post
            $0.maxRetries = 3
            $0.body = .json(self, encoder: .snakeCaseEncoder())
        }
    }
}
