import Domain
import Foundation
import RealHTTP

public struct AppInitRemoteDataSourceImpl: AppInitRemoteDataSource {
    private let client: HTTPClient
    
    public init(client: HTTPClient) {
        self.client = client
    }
    
    public func getAppInit() async throws -> AppInit {
        try await client.fetch(GetAppInitRequestDTO()).toDomain()
    }
}
