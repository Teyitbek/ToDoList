import Domain

public struct ProductsRepositoryImpl: ProductsRepository {
    private let dataSource: ProductsRemoteDataSource
    
    public init(dataSource: ProductsRemoteDataSource) {
        self.dataSource = dataSource
    }
    
    public func getProducts(with categoryId: Int, page: Int, perPage: Int, search: String) async throws -> ProductsPage {
        try await dataSource.getProducts(with: categoryId, page: page, perPage: perPage, search: search)
    }
    
    public func getPopularProducts() async throws -> [ProductRepresentable] {
        try await dataSource.getPopularProducts()
    }
    
    public func searchProducts(page: Int, perPage: Int, search: String) async throws -> ProductsPage {
        try await dataSource.searchProducts(page: page, perPage: perPage, search: search)
    }
}
