import Foundation

public protocol TodosDomainMappable {
    associatedtype DomainModel
    func toDomain() -> DomainModel
}

public struct TodosGenericResponse<T: Decodable>: Decodable {
    public var todos: T
    
    public init(todos: T, message: String) {
        self.todos = todos
    }
}

extension TodosGenericResponse where T: TodosDomainMappable {
    public func toDomain() -> T.DomainModel {
        return todos.toDomain()
    }
}

