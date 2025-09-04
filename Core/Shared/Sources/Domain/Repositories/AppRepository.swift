import Foundation

public protocol AppRepository {
    func getAppInit() async throws -> AppInit
}
