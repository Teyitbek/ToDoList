import Domain

public protocol ProductsRemoteDataSource {
    func getProducts(with categoryId: Int, page: Int, perPage: Int, search: String) async throws -> ProductsPage
    func getPopularProducts() async throws -> [ProductRepresentable]
    func searchProducts(page: Int, perPage: Int, search: String) async throws -> ProductsPage
}
