import Extensions
import RealHTTP

struct LanguagesRequestDTO: Encodable, APIResourceConvertible {
    typealias Result = GenericResponse<[LanguagesDTO]>
    
    func request() -> HTTPRequest {
        HTTPRequest {
            $0.path = "/localization/languages"
            $0.method = .get
            $0.maxRetries = 3
        }
    }
}
