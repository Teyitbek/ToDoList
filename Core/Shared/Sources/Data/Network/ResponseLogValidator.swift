import Foundation
import RealHTTP

public final class ResponseLogValidator: HTTPValidator {
    public init() {}
    
    public func validate(response: HTTPResponse, forRequest request: HTTPRequest) -> HTTPResponseValidatorResult {
        guard let dataRequest = response.urlRequests.current else {
            return .nextValidator
        }
        
        // LOG REQUEST
        log("\n------------------------------")
        log("STATUSCODE: \(response.statusCode.rawValue)")
        log("HTTP METHOD: .\(dataRequest.method?.rawValue ?? "")")
        log("URL: \(dataRequest.url ?? "")")
        
        // LOG HEADERS
        self.logHeaders(headers: dataRequest.allHTTPHeaderFields)
        
        // MARK: LOG REQUEST BODY
        if let body = dataRequest.body {
            log("REQUEST BODY:")
            logBody(data: body)
        }
        
        // RESPONSE ERROR
        guard response.statusCode.responseType == .success else {
            return logError(response: response)
        }
        
        // RESPONSE BODY
        guard let data = response.data else {
            return .nextValidator
        }
        
        log("RESPONSE BODY:")
        logBody(data: data)
       
        return .nextValidator
    }
}

// MARK: LOG METHODS
extension ResponseLogValidator {
    func log(_ text: String) {
        print(text)
    }
    
    func logBody(data: Data) {
        do {
            let jsonObject = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
            let prettyData = try JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted)
            
            if let prettyString = String(data: prettyData, encoding: .utf8) {
                log(prettyString)
            }
        } catch {
            if let string = NSString(data: data, encoding: String.Encoding.utf8.rawValue) {
                log(string as String)
            }
        }
    }
    
    func logHeaders(headers: [AnyHashable: Any]?) {
        guard let headers = headers else {
            return
        }
        log("HEADERS: [")
        for (key, value) in headers {
            log("  \(key): \(value)")
        }
        log("]")
    }
    
    func logError(response: HTTPResponse) -> HTTPResponseValidatorResult {
        guard let error = response.error else {
            return .nextValidator
        }
        log("❌")
        log("❗️ StatusCodeError: \(error.statusCode)")
        log("❗️ DebugDescription: \(error.category)")
        log("❗️ DecodingError: \(error.localizedDescription)")
        if let message = error.message {
            log("❗️ ErrorMessage: \(message)")
        }
        log("❌")
        return .nextValidator
    }
}
