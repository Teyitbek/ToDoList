import Domain
import RealHTTP

public struct TodoRemoteDataSourceImpl: TodoRemoteDataSource {
    private let client: HTTPClient
    
    public init(client: HTTPClient) {
        self.client = client
    }
    
    public func getTodos() async throws ->  [TodoRepresentable] {
        try await client.fetch(TodoRequestDTO()).data.map { $0.toDomain() }
    }
}
