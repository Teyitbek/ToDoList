import Foundation
import Sentry

public struct Message {
    var state: NetworkRequestState = .success
    var request: URLRequest?
    var response: HTTPURLResponse?
    var responseData: Data? = Data("RESPONSE BODY NOT AVAILABLE".utf8)
    var level: SentryLevel = .info
    
    func route() -> String {
        guard let request = request, let url = request.url else { return "NOT AVAILABLE" }
        return url.path
    }
    
    func build() -> String {
        var message = ""
        message += "\n \(state.rawValue)\(route())\n"
        
        if let request = request {
        message += """
        \n Request HTTP Method Type: \(request.httpMethod ?? "Unknown")
        \n Request URL: \(request.debugDescription)
        \n Request Headers: \(request.allHTTPHeaderFields ?? [:])
        \n Request Body: \(String(describing: try? JSONSerialization.jsonObject(with: request.httpBody ?? Data("REQUEST BODY NOT AVAILABLE".utf8), options: [])))\n
        """
        }
        
        if let response = response {
        message += """
        \n Response Status Code: \(response.statusCode)
        \n Response Headers: \(response.allHeaderFields)
        \n Response Body: \(String(describing: try? JSONSerialization.jsonObject(with: responseData!, options: [])))
        """
        }
        
        return message
    }
}
