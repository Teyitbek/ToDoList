import Domain
import StartDomain

public protocol TodoRemoteDataSource {
    func getTodos() async throws -> [TodoRepresentable]
}
