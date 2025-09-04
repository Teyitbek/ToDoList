import Domain
import PincodeDomain

public protocol LoginRemoteDataSource {
    func login(with credentials: Pincodeable) async throws -> UserInfoRepresentable
}
