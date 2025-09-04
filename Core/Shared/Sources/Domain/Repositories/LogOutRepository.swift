import Foundation

public protocol LogOutRepository {
    func logOut() async throws -> String?
}
