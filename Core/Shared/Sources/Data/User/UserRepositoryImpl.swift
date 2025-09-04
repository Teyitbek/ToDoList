import Domain

public final class UserRepositoryImpl: UserRepository {
    private let dataSource: UserKeychainDataSource
    
    public init(dataSource: UserKeychainDataSource) {
        self.dataSource = dataSource
    }
    
    public func save(user: UserRepresentable) throws {
        try dataSource.save(user: user)
    }
    
    public func retrieveUser() throws -> UserRepresentable? {
        try dataSource.retrieve()
    }
    
    public func delete() throws {
        try dataSource.delete()
    }
}
