import Domain

public protocol TodoUseCase {
    func execute() async throws -> [TodoRepresentable]
}

public final class TodoUseCaseImpl: TodoUseCase {
    private let repository: TodoRepository
    
    public init(repository: TodoRepository) {
        self.repository = repository
    }
    
    public func execute() async throws -> [TodoRepresentable] {
        try await repository.getTodos()
    }
}
