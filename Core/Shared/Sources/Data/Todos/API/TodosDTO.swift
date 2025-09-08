import Domain

public struct TodosDTO: Codable, TodosDomainMappable {
    public var todo: String?
    public var id: Int64
    public var completed: Bool
    public var userId: Int64
    
    public init(from todos: TodoRepresentable) {
        self.todo = todos.todo
        self.id = todos.id
        self.completed = todos.completed
        self.userId = todos.userId
    }
    
    public func toDomain() -> TodoRepresentable {
        Todo(todo: self.todo, id: self.id, completed: self.completed, userId: self.userId)
    }
}
