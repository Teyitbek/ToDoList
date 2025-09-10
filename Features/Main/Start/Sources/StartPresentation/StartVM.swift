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
    
    var todoModel: [TodoRepresentable] = []
    var initialTodoModel: [TodoRepresentable] = []
    
    @MainActor
    public func getRemoteData() {
        activityIndicatorIsHiddenSubject.send(false)
        getDataTask = Task {
            do {
                let remoteTodos = try await useCases.getTodos.execute()
                let localTodos = coreDataManager.model.filter { $0.uuid != nil && $0.id == 0 }

                let combined = localTodos + remoteTodos
                todosSubject.send(combined)
                initialTodoModel = combined
                todoModel = combined

                coreDataManager.deleteAllModels()
                combined.forEach { coreDataManager.add($0) }

                dump(coreDataManager.model)
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
            if let index = coreDataManager.model.firstIndex(where: { $0.uuid == uuid }) {
                coreDataManager.model[index].deleteModel()
                coreDataManager.fetchAllModel()
                todoModel = coreDataManager.model
                initialTodoModel = coreDataManager.model
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
                initialTodoModel.removeAll { $0.id == todo.id }
                todoModel.removeAll { $0.id == todo.id }
                if let index = coreDataManager.model.firstIndex(where: { $0.id == todo.id }) {
                    coreDataManager.model[index].deleteModel()
                }
                coreDataManager.fetchAllModel()
                todoModel = coreDataManager.model
                initialTodoModel = coreDataManager.model
                deleteSubject.send(true)
            } catch {
                errorSubject.send(error)
                activityIndicatorIsHiddenSubject.send(true)
            }
        }
    }
    
    public func getLocalData() {
        activityIndicatorIsHiddenSubject.send(false)
        coreDataManager.fetchAllModel()
        dump(coreDataManager.model)
        todoModel.removeAll()
        initialTodoModel.removeAll()
        todoModel = coreDataManager.model
        initialTodoModel = coreDataManager.model
        todosSubject.send(coreDataManager.model)
        activityIndicatorIsHiddenSubject.send(true)
    }
}
