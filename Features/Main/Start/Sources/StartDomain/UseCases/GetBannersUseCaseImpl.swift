import Domain

public struct GetBannersUseCaseImpl: GetBannersUseCase {
    private let repository: BannerRepository
    
    public init(repository: BannerRepository) {
        self.repository = repository
    }
    
    public func execute() async throws -> [any BannerRepresentable] {
        try await repository.getBanners()
    }
}
