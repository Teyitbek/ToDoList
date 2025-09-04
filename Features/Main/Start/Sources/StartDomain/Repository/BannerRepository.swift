import Domain

public protocol BannerRepository {
    func getBanners() async throws -> [any BannerRepresentable]
}
