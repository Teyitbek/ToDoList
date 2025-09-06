import Domain

public protocol TodoRepository {
    func getTodos() async throws -> [TodoRepresentable]
}
