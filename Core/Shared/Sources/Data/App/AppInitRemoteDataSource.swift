import Foundation
import Domain

public protocol AppInitRemoteDataSource {
    func getAppInit() async throws -> AppInit
}

