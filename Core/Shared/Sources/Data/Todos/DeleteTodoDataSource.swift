import Domain

public protocol DeleteTodoDataSource {
    func deleteTodo(with id: Int) async throws -> DeleteTodoResponse
}
