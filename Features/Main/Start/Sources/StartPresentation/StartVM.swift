import Combine
import UIKit
import Foundation
import Data
import Domain
import StartDomain
import StartData
import Base

public protocol StartViewModel {
    var onStartAction: CompletionClosure? { get set }
    var onDetailsAction: ((_ delegate: ActionProtocol, _ todo: TodoRepresentable?) -> Void)? { get set }
    
    @MainActor
    func getRemoteData()
    
    @MainActor
    func delete(todo: TodoRepresentable)
    
    func getLocalData()
}

public typealias UseCases = (getTodos: TodosUseCase, deleteTodo: DeleteTodoUseCase)

public final class StartVM: ViewModel, StartViewModel {
    public var onStartAction: CompletionClosure?
    public var onDetailsAction: ((_ delegate: ActionProtocol, _ todo: TodoRepresentable?) -> Void)?
    
    public var getDataTask: Task<Void, Never>?
    public var todosSubject = CurrentValueSubject<[TodoRepresentable], Never>([])
    public var todosEmptySubject = PassthroughSubject<Bool, Never>()
    public var deleteSubject = PassthroughSubject<Bool, Never>()
    
    public var coreDataManager: CoreDataManager
    public var sessionService: SessionManaging
    public var useCases: UseCases
    
    public init(coreDataManager: CoreDataManager, sessionService: SessionManaging, useCases: UseCases) {
        self.coreDataManager = coreDataManager
        self.sessionService = sessionService
        self.useCases = useCases
        super.init()
    }
    
    var isSearchingMode = false
    
    var todos: [TodoRepresentable] = []
    var initialTodos: [TodoRepresentable] = []
    
    @MainActor
    public func getRemoteData() {
        activityIndicatorIsHiddenSubject.send(false)
        getDataTask = Task {
            do {
                let remoteTodos = try await useCases.getTodos.execute()
                let localTodos = coreDataManager.todoData.filter { $0.uuid != nil && $0.id == 0 }

                let combined = localTodos + remoteTodos
                todosSubject.send(combined)
                initialTodos = combined
                todos = combined

                coreDataManager.deleteAllModels()
                combined.forEach { coreDataManager.add($0) }

                dump(coreDataManager.todoData)
                activityIndicatorIsHiddenSubject.send(true)
            } catch {
                errorSubject.send(error)
                activityIndicatorIsHiddenSubject.send(true)
            }
        }
    }
    
    @MainActor
    public func delete(todo: TodoRepresentable) {
        // local deletion
        activityIndicatorIsHiddenSubject.send(false)
        if let uuid = todo.uuid {
            if let index = coreDataManager.todoData.firstIndex(where: { $0.uuid == uuid }) {
                coreDataManager.todoData[index].deleteModel()
                coreDataManager.fetchAllModel()
                todos = coreDataManager.todoData
                initialTodos = coreDataManager.todoData
                deleteSubject.send(true)
            }
            activityIndicatorIsHiddenSubject.send(true)
            return
        }
        // remote deletion
        getDataTask = Task {
            do {
                let todo = try await useCases.deleteTodo.execute(with: Int(todo.id))
                activityIndicatorIsHiddenSubject.send(true)
                initialTodos.removeAll { $0.id == todo.id }
                todos.removeAll { $0.id == todo.id }
                if let index = coreDataManager.todoData.firstIndex(where: { $0.id == todo.id }) {
                    coreDataManager.todoData[index].deleteModel()
                }
                coreDataManager.fetchAllModel()
                todos = coreDataManager.todoData
                initialTodos = coreDataManager.todoData
                deleteSubject.send(true)
            } catch {
                errorSubject.send(error)
                activityIndicatorIsHiddenSubject.send(true)
            }
        }
    }
    
    public func getLocalData() {
        coreDataManager.fetchAllModel()
        todos = coreDataManager.todoData
        initialTodos = coreDataManager.todoData
        todosSubject.send(coreDataManager.todoData)
        if todos.isEmpty {
            todosEmptySubject.send(true)
        }
    }
}
