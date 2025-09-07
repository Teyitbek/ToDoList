import Domain
import Foundation

public protocol DeleteTodoRepository {
    func deleteTodo(with id: Int) async throws -> DeleteTodoResponse
}
