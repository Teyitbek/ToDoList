import Domain

public protocol LoginRepository {
    func login(with credentials: Pincodeable) async throws -> UserInfoRepresentable
}
