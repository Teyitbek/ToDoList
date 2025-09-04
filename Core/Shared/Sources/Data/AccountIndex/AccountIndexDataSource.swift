import Domain

public protocol AccountIndexDataSource {
    func index() async throws -> UserRepresentable
}
