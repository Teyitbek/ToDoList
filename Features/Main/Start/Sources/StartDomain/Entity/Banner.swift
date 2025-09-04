import Domain
import Foundation

public struct Banner: BannerRepresentable, Sendable {
    public var path: String?
    
    public init(path: String? = nil) {
        self.path = path
    }
}
