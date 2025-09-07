import Domain

public struct DeleteTodoRepositoryImpl: DeleteTodoRepository {
    private let dataSource: DeleteTodoDataSource
    
    public init(dataSource: DeleteTodoDataSource) {
        self.dataSource = dataSource
    }
    
    public func deleteTodo(with id: Int) async throws -> DeleteTodoResponse {
        try await dataSource.deleteTodo(with: id)
    }
}
