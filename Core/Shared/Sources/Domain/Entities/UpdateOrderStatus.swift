import Foundation

public struct UpdateOrderStatus: Encodable {
    public let source: String
    public let status: String
    
    public init(source: String, status: String) {
        self.source = source
        self.status = status
    }
}
