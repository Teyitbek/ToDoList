import Domain
import PincodeDomain

public struct LoginRepositoryImpl: LoginRepository {
    private let remoteDataSource: LoginRemoteDataSource
    
    public init(remoteDataSource: LoginRemoteDataSource) {
        self.remoteDataSource = remoteDataSource
    }
    
    public func login(with credentials: any Pincodeable) async throws -> any UserInfoRepresentable {
        try await remoteDataSource.login(with: credentials)
    }
}
