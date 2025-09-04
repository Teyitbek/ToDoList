//import Foundation
//import RealHTTP
//
//public final class ResponseMessageValidator: HTTPValidator {
//    public init() {}
//    
//    public func validate(response: HTTPResponse, forRequest request: HTTPRequest) -> HTTPResponseValidatorResult {
//        guard response.statusCode.responseType == .clientError else {
//            return .nextValidator
//        }
//        
//        guard let data = response.data, let message = ResponseMessage(jsonData: data) else {
//            return .nextValidator
//        }
//        
//        return .failChain(message)
//    }
//}
