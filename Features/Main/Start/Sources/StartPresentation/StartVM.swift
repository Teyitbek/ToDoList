import Combine
import UIKit
import Foundation
import Data
import Domain
import StartDomain
import Base

public struct ToDoModel {
    public var id: Int
    public var todo: String
    public var completed: Bool = false
    public var userId: Int
}

public protocol StartViewModel {
    var onStartAction: CompletionClosure? { get set }
    var onAddNewNoteAction: CompletionClosure? { get set }
    var onDetailsAction: CompletionClosure? { get set }
}

public typealias UseCases = ()

public final class StartVM: ViewModel, StartViewModel {
    public var onStartAction: CompletionClosure?
    public var onAddNewNoteAction: CompletionClosure?
    public var onDetailsAction: CompletionClosure?
        
    public var sessionService: SessionManaging
    public var useCases: UseCases
    
    public init(sessionService: SessionManaging, useCases: UseCases) {
        self.sessionService = sessionService
        self.useCases = useCases
        super.init()
    }
    
    var isSearchingMode = false
    
    var todoModel: [ToDoModel] = []
    var initialTodoModel: [ToDoModel] = [
        .init(id: 1, todo: "Do something nice for someone you care about", userId: 152),
        .init(id: 2, todo: "Memorize a poem", userId: 152),
        .init(id: 3, todo: "Watch a classic movie", userId: 152),
        .init(id: 4, todo: "Watch a documentary", userId: 152),
        .init(id: 5, todo: "Invest in cryptocurrency", userId: 152),
        .init(id: 6, todo: "Contribute code or a monetary donation to an open-source software project", userId: 152),
        .init(id: 7, todo: "olve a Rubik's cube", userId: 152),
        .init(id: 1, todo: "Do something nice for someone you care about", userId: 152),
        .init(id: 2, todo: "Memorize a poem", userId: 152),
        .init(id: 3, todo: "Watch a classic movie", userId: 152),
        .init(id: 4, todo: "Watch a documentary", userId: 152),
        .init(id: 5, todo: "Invest in cryptocurrency", userId: 152),
        .init(id: 6, todo: "Contribute code or a monetary donation to an open-source software project", userId: 152),
        .init(id: 7, todo: "olve a Rubik's cube", userId: 152)
    ]
}
