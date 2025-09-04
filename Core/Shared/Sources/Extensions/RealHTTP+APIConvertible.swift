import Foundation
import RealHTTP

public protocol APIResourceConvertible {
    associatedtype Result: Decodable // the output object of the service
    func request() -> HTTPRequest // function which generate a request
}

public extension HTTPClient {
    func fetch<T: APIResourceConvertible>(_ convertible: T) async throws -> T.Result {
        let result = try await convertible.request().fetch(self)
        do {
            return try result.decode(T.Result.self, decoder: .snakeCaseDecoder())
        } catch let error as DecodingError {
            
            let path: String
            let debug: String
            
            switch error {
            case .typeMismatch(_, let context),
                 .valueNotFound(_, let context),
                 .keyNotFound(_, let context),
                 .dataCorrupted(let context):
                path = context.codingPath.map { $0.stringValue }.joined(separator: ".")
                debug = context.debugDescription
            @unknown default:
                path = "Unknown"
                debug = "Unknown decoding error"
            }
            
            print("💥 Decoding failed at: \(path)")
            print("🛠️ Description: \(debug)")
            
            throw NSError(domain: "com.ToDoList.app", code: 0, userInfo: [NSLocalizedDescriptionKey: "💥 Decoding failed at: \(path) \n 🛠️ Description: \(debug)"])
        } catch {
            throw error
        }
    }
}
