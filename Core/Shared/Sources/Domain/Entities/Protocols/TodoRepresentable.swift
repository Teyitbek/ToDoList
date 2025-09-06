import Foundation
import UIKit

public protocol TodoRepresentable: Sendable {
    var id: Int { get }
    var todo: String { get }
    var completed: Bool { get }
    var userId: Int { get }
}

public struct TodoModel: TodoRepresentable {
    public var id: Int
    public var todo: String
    public var completed: Bool
    public var userId: Int
    
    public init(id: Int, todo: String, completed: Bool, userId: Int) {
        self.id = id
        self.todo = todo
        self.completed = completed
        self.userId = userId
    }
}
