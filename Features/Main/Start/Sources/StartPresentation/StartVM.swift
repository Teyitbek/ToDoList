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
    var onDetailsAction: ((TodoRepresentable?) -> Void)? { get set }
    
    @MainActor
    func getRemoteData()
    
    @MainActor
    func deleteTodo(with id: Int)
    
    func getLocalData()
}

public typealias UseCases = (getTodos: TodosUseCase, deleteTodo: DeleteTodoUseCase)

public final class StartVM: ViewModel, StartViewModel {
    public var onStartAction: CompletionClosure?
    public var onDetailsAction: ((TodoRepresentable?) -> Void)?
    
    public var getDataTask: Task<Void, Never>?
    public var todosSubject = CurrentValueSubject<[TodoRepresentable], Never>([])
    public var deleteSubject = PassthroughSubject<DeleteTodoResponse, Never>()
    
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
                let todo = try await useCases.getTodos.execute()
                todosSubject.send(todo)
                coreDataManager.model.removeAll()
                todo.forEach { coreDataManager.add($0) }
                dump(coreDataManager.model)
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
                coreDataManager.model.removeAll { todo.id == $0.id }
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
        coreDataManager.model.forEach { todoModel.append($0) }
        todosSubject.send(todoModel)
        activityIndicatorIsHiddenSubject.send(true)
    }
}
