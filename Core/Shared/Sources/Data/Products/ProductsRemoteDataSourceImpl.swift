import Domain
import RealHTTP

public struct ProductsRemoteDataSourceImpl: ProductsRemoteDataSource {
    private let client: HTTPClient
    
    public init(client: HTTPClient) {
        self.client = client
    }
    
    public func getProducts(with categoryId: Int, page: Int, perPage: Int, search: String) async throws -> ProductsPage {
        let response = try await client.fetch(ProductsRequestDTO(categoryId: categoryId, search: search, pageInfo: .init(page: page, perPage: perPage)))
        return ProductsPage(data: response.data.map { $0.toDomain() },
                            perPage: response.perPage,
                            page: response.page,
                            totalPage: response.totalPage,
                            totalItems: response.totalItems)
    }
    
    public func getPopularProducts() async throws -> [ProductRepresentable] {
        return try await client.fetch(PopularProductsRequestDTO()).data.map({ $0.toDomain() })
    }
    
    public func searchProducts(page: Int, perPage: Int, search: String) async throws -> ProductsPage {
        let response = try await client.fetch(SearchProductsRequestDTO(search: search, pageInfo: .init(page: page, perPage: perPage)))
        return ProductsPage(data: response.data.map { $0.toDomain() },
                            perPage: response.perPage,
                            page: response.page,
                            totalPage: response.totalPage,
                            totalItems: response.totalItems)
    }
}
