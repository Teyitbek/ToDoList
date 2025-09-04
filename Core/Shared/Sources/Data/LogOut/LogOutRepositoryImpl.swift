import Domain

public struct LogOutRepositoryImpl: LogOutRepository {
    private let remoteDataSource: KitchenRemoteDataSource
    
    public init(remoteDataSource: KitchenRemoteDataSource) {
        self.remoteDataSource = remoteDataSource
    }
    
    public func logOut() async throws -> String? {
        try await remoteDataSource.logOut()
    }
}
