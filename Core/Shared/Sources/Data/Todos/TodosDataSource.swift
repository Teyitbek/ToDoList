import Domain

public protocol TodosDataSource {
    func todos() async throws -> [TodoRepresentable]
}
