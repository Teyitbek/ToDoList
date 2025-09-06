import Domain
import StartDomain

public struct TodoRepositoryImpl: TodoRepository {
    private let remoteDataSource: TodoRemoteDataSource
    
    public init(remoteDataSource: TodoRemoteDataSource) {
        self.remoteDataSource = remoteDataSource
    }
    
    public func getTodos() async throws -> [TodoRepresentable] {
        try await remoteDataSource.getTodos()
    }
}
