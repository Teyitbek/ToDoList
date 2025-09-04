import Domain
import RealHTTP

public struct AccountIndexDataSourceImpl: AccountIndexDataSource {
    private let client: HTTPClient
    
    public init(client: HTTPClient) {
        self.client = client
    }
    
    public func index() async throws -> UserRepresentable {
        try await client.fetch(AccountIndexRequestDTO()).toDomain()
    }
}
