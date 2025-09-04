import Foundation

public protocol LocationRepository {
    func save(location: Locationable) throws
    func getLocation() throws -> Locationable?
    func deleteLocation() throws
}
