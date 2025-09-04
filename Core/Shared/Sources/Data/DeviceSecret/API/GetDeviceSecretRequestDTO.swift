import Foundation
import RealHTTP
import Extensions

struct GetDeviceSecretRequestDTO: Encodable, APIResourceConvertible {
    typealias Result = GenericResponse<DeviceSecretDTO>
    
    func request() -> HTTPRequest {
        HTTPRequest {
            $0.path = "/account/get-device-secret"
            $0.method = .get
            $0.maxRetries = 3
        }
    }
}
