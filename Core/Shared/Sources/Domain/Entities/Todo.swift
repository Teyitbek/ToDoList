import Foundation

public class Todo: TodoRepresentable {
    public var todo: String
    public var id: Int
    public var completed: Bool
    public var userId: Int
    
    public init(todo: String, id: Int, completed: Bool, userId: Int) {
        self.todo = todo
        self.id = id
        self.completed = completed
        self.userId = userId
    }
}
