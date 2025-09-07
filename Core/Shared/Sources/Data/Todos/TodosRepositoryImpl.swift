import Domain

public struct TodosRepositoryImpl: TodosRepository {
    private let dataSource: TodosDataSource
    
    public init(dataSource: TodosDataSource) {
        self.dataSource = dataSource
    }
    
    public func todos() async throws -> [TodoRepresentable] {
        try await dataSource.todos()
    }
}
