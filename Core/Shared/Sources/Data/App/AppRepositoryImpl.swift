import Foundation
import Domain

public struct AppRepositoryImpl: AppRepository {
    private let dataSource: AppInitRemoteDataSource
    
    public init(dataSource: AppInitRemoteDataSource) {
        self.dataSource = dataSource
    }
    
    public func getAppInit() async throws -> AppInit {
        try await dataSource.getAppInit()
    }
}
