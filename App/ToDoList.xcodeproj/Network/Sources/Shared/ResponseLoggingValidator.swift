import NetworkLogger
import RealHTTP

final class ResponseLoggingValidator: HTTPValidator {
    var networkLogger: NetworkLoggable
    
    init(networkLogger: NetworkLoggable) {
        self.networkLogger = networkLogger
    }
    
    func validate(response: HTTPResponse, forRequest request: HTTPRequest) -> HTTPResponseValidatorResult {
        guard response.error != nil else {
            return .nextValidator
        }
        
        networkLogger.log(with: response.urlRequests.original, response: response.httpResponse, data: response.data, level: .error, state: .failure)
        
        return .nextValidator
    }
}
