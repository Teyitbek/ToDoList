import Domain
import RealHTTP

public struct TodosDataSourceImpl: TodosDataSource {
    private let client: HTTPClient
    
    public init(client: HTTPClient) {
        self.client = client
    }
    
    public func todos() async throws -> [TodoRepresentable] {
        return try await client.fetch(TodosRequestDTO()).todos.map { $0.toDomain() }
    }
}
