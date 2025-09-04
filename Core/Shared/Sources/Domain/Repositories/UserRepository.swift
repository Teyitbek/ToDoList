import Foundation

public protocol UserRepository {
    func save(user: UserRepresentable) throws
    func retrieveUser() throws -> UserRepresentable?
    func delete() throws
}
