import Foundation

public protocol UserInfoRepresentable: Tokenizable, Sendable {
    var accessToken: String { get }
    var data: UserRepresentable { get }
}
