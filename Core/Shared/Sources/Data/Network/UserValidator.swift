//import Combine
//import Foundation
//import RealHTTP
//
//public final class UserValidator: HTTPValidator {
//    private var logOutSubject: PassthroughSubject<Bool, Never>
//    
//    public init(logOutClosure: PassthroughSubject<Bool, Never>) {
//        self.logOutSubject = logOutClosure
//    }
//    
//    public func validate(response: HTTPResponse, forRequest request: HTTPRequest) -> HTTPResponseValidatorResult {
//        guard response.statusCode == .unauthorized else {
//            return .nextValidator
//        }
//        
//        guard let data = response.data, let message = ResponseMessage(jsonData: data) else {
//            return .nextValidator
//        }
//        
//        logOutSubject.send(true)
//        
//        return .failChain(message)
//    }
//}
