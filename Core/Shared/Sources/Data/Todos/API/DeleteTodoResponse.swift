import Foundation

public struct DeleteTodoResponse: Decodable, Sendable {
    public let id: Int
    public let todo: String
    public let completed: Bool
    public let userId: Int
    public let isDeleted: Bool
    public let deletedOn: String
}
