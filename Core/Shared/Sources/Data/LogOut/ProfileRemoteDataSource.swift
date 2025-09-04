import Foundation

public protocol KitchenRemoteDataSource {
    func logOut() async throws -> String?
}
