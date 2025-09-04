import Data
import Extensions
import RealHTTP

struct DeviceUIDRequestDTO: Encodable, APIResourceConvertible {
    let appType: String
    let appVersion: String
    
    typealias Result = DeviceUIDResponse
    
    func request() -> HTTPRequest {
        HTTPRequest {
            $0.path = "/auth/create-in-store-device"
            $0.maxRetries = 3
            $0.method = .post
        }
    }
}
