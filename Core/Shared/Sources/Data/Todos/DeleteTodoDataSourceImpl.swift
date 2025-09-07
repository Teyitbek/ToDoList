import Domain
import RealHTTP

public struct DeleteTodoDataSourceImpl: DeleteTodoDataSource {
    private let client: HTTPClient
    
    public init(client: HTTPClient) {
        self.client = client
    }
    
    public func deleteTodo(with id: Int) async throws -> DeleteTodoResponse {
        return try await client.fetch(DeleteTodoRequestDTO(id: id))
    }
}
