import Domain
import Data

public struct DeleteTodoUseCaseImpl: DeleteTodoUseCase {
    private let repository: DeleteTodoRepository
    
    public init(repository: DeleteTodoRepository) {
        self.repository = repository
    }
    
    public func execute(with id: Int) async throws -> DeleteTodoResponse {
        try await repository.deleteTodo(with: id)
    }
}
