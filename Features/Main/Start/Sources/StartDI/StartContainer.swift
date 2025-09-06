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
    
    public var todoRemoteDataSource: Factory<TodoRemoteDataSource> {
        Factory(self) {
            TodoRemoteDataSourceImpl(client: AppContainer.shared.client())
        }
    }
    
    public var todoRepository: Factory<TodoRepository> {
        Factory(self) {
            TodoRepositoryImpl(remoteDataSource: self.todoRemoteDataSource())
        }
    }
    
    public var todoUseCase: Factory<TodoUseCase> {
        Factory(self) {
            TodoUseCaseImpl(repository: self.todoRepository())
        }
    }
    
    public init() {}
}
