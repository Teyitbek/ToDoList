import Foundation

public struct ResponseMessage: Decodable, LocalizedError {
    public let message: String
    
    public var errorDescription: String? {
        return message
    }
}
