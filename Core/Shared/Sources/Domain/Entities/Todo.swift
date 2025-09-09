import Foundation

public class Todo: TodoRepresentable {
    public var todo: String?
    public var subtitle: String?
    public var id: Int64
    public var completed: Bool
    public var userId: Int64
    
    public init(todo: String?, id: Int64, completed: Bool, userId: Int64) {
        self.todo = todo
        self.id = id
        self.completed = completed
        self.userId = userId
    }
}
