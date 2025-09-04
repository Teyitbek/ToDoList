import StartDomain
import Domain

public struct BannerRepositoryImpl: BannerRepository {
    private let remoteDataSource: BannerRemoteDataSource
    
    public init(remoteDataSource: BannerRemoteDataSource) {
        self.remoteDataSource = remoteDataSource
    }
    
    public func getBanners() async throws -> [any BannerRepresentable] {
        try await remoteDataSource.getBanners()
    }
}
