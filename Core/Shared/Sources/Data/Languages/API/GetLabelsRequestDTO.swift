import Extensions
import Foundation
import RealHTTP

struct GetLabelsRequestDTO: Encodable, APIResourceConvertible {
    let language: String
    
    typealias Result = GenericResponse<[String: String]>
    
    func request() -> HTTPRequest {
        HTTPRequest {
            $0.path = "/localization/labels"
            $0.addQueryParameter(name: "language", value: language)
            $0.method = .get
            $0.maxRetries = 3
        }
    }
}
