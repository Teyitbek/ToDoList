import Foundation
import Extensions
import RealHTTP

struct GetAppInitRequestDTO: Encodable, APIResourceConvertible {
    typealias Result = GenericResponse<AppInitDTO>
    
    func request() -> HTTPRequest {
        HTTPRequest {
            $0.path = "/app/init"
            $0.method = .get
            $0.maxRetries = 3
        }
    }
}
