//import Combine
//import Foundation
//import RealHTTP
//
//public final class DeviceValidator: HTTPValidator {
//    private var deleteLocationSubject: PassthroughSubject<Bool, Never>
//    
//    public init(deleteLocationSubject: PassthroughSubject<Bool, Never>) {
//        self.deleteLocationSubject = deleteLocationSubject
//    }
//    
//    public func validate(response: HTTPResponse, forRequest request: HTTPRequest) -> HTTPResponseValidatorResult {
//        guard response.statusCode == .preconditionRequired else {
//            return .nextValidator
//        }
//        
//        guard let data = response.data, let message = ResponseMessage(jsonData: data) else {
//            return .nextValidator
//        }
//        
//        deleteLocationSubject.send(true)
//        
//        return .failChain(message)
//    }
//}
