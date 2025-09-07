import Domain
import Data  

public struct TodosUseCaseImpl: TodosUseCase {
    private let repository: TodosRepository
    
    public init(repository: TodosRepository) {
        self.repository = repository
    }
    
    public func execute() async throws -> [TodoRepresentable] {
        try await repository.todos()
    }
}
