import AppContainer
import Combine
import Data
import Domain
import Factory
import StartDomain
import StartData

public final class StartContainer: ManagedContainer {
    public let manager: ContainerManager = ContainerManager()
    
    public var labelsSubject: Factory<CurrentValueSubject<[String:String], Never>> {
        Factory(self) {
            AppContainer.shared.labelsSubject()
        }
    }
    
    public var sessionService: Factory<SessionManaging> {
        Factory(self) {
            AppContainer.shared.sessionService()
        }
    }
    
    // MARK: - Todo
    public var todosDataSource: Factory<TodosDataSource> {
        Factory(self) {
            TodosDataSourceImpl(client: AppContainer.shared.client())
        }
    }
    
    public var todosRepository: Factory<TodosRepository> {
        Factory(self) {
            TodosRepositoryImpl(dataSource: self.todosDataSource())
        }
    }
    
    public var todosUseCase: Factory<TodosUseCase> {
        Factory(self) {
            TodosUseCaseImpl(repository: self.todosRepository())
        }
    }
    
    // MARK: - Delete Todo
    public var deleteTodoDataSource: Factory<DeleteTodoDataSource> {
        Factory(self) {
            DeleteTodoDataSourceImpl(client: AppContainer.shared.client())
        }
    }
    
    public var deleteTodoRepository: Factory<DeleteTodoRepository> {
        Factory(self) {
            DeleteTodoRepositoryImpl(dataSource: self.deleteTodoDataSource())
        }
    }
    
    public var deleteTodoUseCase: Factory<DeleteTodoUseCase> {
        Factory(self) {
            DeleteTodoUseCaseImpl(repository: self.deleteTodoRepository())
        }
    }
    
    // MARK: - Core Data
    public var coreDataManager: Factory<CoreDataManager> {
        Factory(self) {
            AppContainer.shared.coreDataManager()
        }
    }
    
    public init() {}
}
