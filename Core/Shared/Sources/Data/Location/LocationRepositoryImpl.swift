import Domain

public final class LocationRepositoryImpl: LocationRepository {
    private let dataSource: LocationKeychainDataSource
    
    public init(dataSource: LocationKeychainDataSource) {
        self.dataSource = dataSource
    }
    
    public func save(location: Locationable) throws {
        try dataSource.save(location: Location(id: location.id, name: location.name))
    }
    
    public func getLocation() throws -> Locationable? {
        try dataSource.retrieve()
    }
    
    public func deleteLocation() throws {
        try dataSource.deleteLocation()
    }
}
