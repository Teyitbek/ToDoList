import Data
import Extensions
import Foundation
import RealHTTP

struct BannerRequestDTO: Encodable, APIResourceConvertible {
    typealias Result = GenericResponse<[BannerDTO]>
    
    func request() -> HTTPRequest {
        HTTPRequest {
            $0.path = "/banners"
            $0.method = .get
            $0.maxRetries = 3
        }
    }
}
