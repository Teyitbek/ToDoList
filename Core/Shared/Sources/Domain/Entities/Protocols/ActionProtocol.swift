import Foundation

@MainActor
public protocol ActionProtocol: AnyObject {
    func didSendDelete(todo: TodoRepresentable)
}
