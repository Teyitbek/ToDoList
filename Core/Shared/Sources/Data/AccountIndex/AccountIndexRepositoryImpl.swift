import Domain

public struct AccountIndexRepositoryImpl: AccountIndexRepository {
    private let dataSource: AccountIndexDataSource
    
    public init(dataSource: AccountIndexDataSource) {
        self.dataSource = dataSource
    }
    
    public func getIndex() async throws -> any UserRepresentable {
        try await dataSource.index()
    }
}
