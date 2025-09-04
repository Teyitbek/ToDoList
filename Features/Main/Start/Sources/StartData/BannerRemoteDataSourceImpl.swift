import StartDomain
import Domain
import RealHTTP

public protocol BannerRemoteDataSource {
    func getBanners() async throws -> [any BannerRepresentable]
}

public struct BannerRemoteDataSourceImpl: BannerRemoteDataSource {
    private let client: HTTPClient
    
    public init(client: HTTPClient) {
        self.client = client
    }
    
    public func getBanners() async throws -> [any BannerRepresentable] {
        try await client.fetch(BannerRequestDTO()).data.map { $0.toDomain() }
    }
}
