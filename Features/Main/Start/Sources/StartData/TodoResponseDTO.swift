import Data
import Domain
import Foundation

public struct TodoDTO: Codable, DomainMappable {
    var id: Int
    var todo: String
    var completed: Bool
    var userId: Int
    
    public init(id: Int, todo: String, completed: Bool, userId: Int) {
        self.id = id
        self.todo = todo
        self.completed = completed
        self.userId = userId
    }
}
public extension TodoDTO {
    func toDomain() -> TodoModel {
        TodoModel(id: id, todo: todo, completed: completed, userId: userId)
    }
}
