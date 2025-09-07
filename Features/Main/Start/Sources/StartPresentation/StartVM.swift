import Combine
import UIKit
import Foundation
import Data
import Domain
import StartDomain
import Base

public protocol StartViewModel {
    var onStartAction: CompletionClosure? { get set }
    var onAddNewNoteAction: CompletionClosure? { get set }
    var onDetailsAction: CompletionClosure? { get set }
    
    @MainActor
    func getData()
}

public final class StartVM: ViewModel, StartViewModel {
    public var onStartAction: CompletionClosure?
    public var onAddNewNoteAction: CompletionClosure?
    public var onDetailsAction: CompletionClosure?
    
    public var getDataTask: Task<Void, Never>?
    public var todosSubject = CurrentValueSubject<[TodoRepresentable], Never>([])
    
    public var sessionService: SessionManaging
    public var todosUseCase: TodosUseCase
    
    public init(sessionService: SessionManaging, todosUseCase: TodosUseCase) {
        self.sessionService = sessionService
        self.todosUseCase = todosUseCase
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
                let todo = try await todosUseCase.execute()
                todosSubject.send(todo)
                activityIndicatorIsHiddenSubject.send(true)
            } catch {
                errorSubject.send(error)
                activityIndicatorIsHiddenSubject.send(true)
            }
        }
    }
}
