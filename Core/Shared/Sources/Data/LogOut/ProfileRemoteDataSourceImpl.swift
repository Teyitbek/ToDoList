import Foundation
import RealHTTP

public struct KitchenRemoteDataSourceImpl: KitchenRemoteDataSource {
    private let client: HTTPClient
    
    public init (client: HTTPClient) {
        self.client = client
    }
    
    public func logOut() async throws -> String? {
        try await client.fetch(LogOutRequestDTO()).message
    }
}
