import Combine
import UIKit
import Foundation
import Data
import Domain
import StartDomain
import Base

public protocol StartViewModel {
    var onStartAction: CompletionClosure? { get set }
    var onDetailsAction: ((TodoRepresentable?) -> Void)? { get set }
    
    @MainActor
    func getData()
    
    @MainActor
    func deleteTodo(with id: Int)
}

public typealias UseCases = (getTodos: TodosUseCase, deleteTodo: DeleteTodoUseCase)

public final class StartVM: ViewModel, StartViewModel {
    public var onStartAction: CompletionClosure?
    public var onDetailsAction: ((TodoRepresentable?) -> Void)?
    
    public var getDataTask: Task<Void, Never>?
    public var todosSubject = CurrentValueSubject<[TodoRepresentable], Never>([])
    public var deleteSubject = PassthroughSubject<DeleteTodoResponse, Never>()
    
    public var sessionService: SessionManaging
    public var useCases: UseCases
    
    public init(sessionService: SessionManaging, useCases: UseCases) {
        self.sessionService = sessionService
        self.useCases = useCases
        super.init()
    }
    
    var isSearchingMode = false
    
    var todoModel: [TodoRepresentable] = []
    var initialTodoModel: [TodoRepresentable] = []
    
    @MainActor
    public func getData() {
        activityIndicatorIsHiddenSubject.send(false)
        
        getDataTask = Task {
            do {
                let todo = try await useCases.getTodos.execute()
                todosSubject.send(todo)
                activityIndicatorIsHiddenSubject.send(true)
            } catch {
                errorSubject.send(error)
                activityIndicatorIsHiddenSubject.send(true)
            }
        }
    }
    
    @MainActor
    public func deleteTodo(with id: Int) {
        activityIndicatorIsHiddenSubject.send(false)
        
        getDataTask = Task {
            do {
                let todo = try await useCases.deleteTodo.execute(with: id)
                deleteSubject.send(todo)
                activityIndicatorIsHiddenSubject.send(true)
            } catch {
                errorSubject.send(error)
                activityIndicatorIsHiddenSubject.send(true)
            }
        }
    }
}
