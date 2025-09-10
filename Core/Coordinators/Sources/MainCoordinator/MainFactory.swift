import StartDI
import StartPresentation
import DetailsDI
import DetailsPresentation
import Domain
import Combine
import UIKit

public protocol MainFactory {
    func makeStartModule() -> StartVC
    func makeDetailsmodule(delegate: ActionProtocol, todo: TodoRepresentable?) -> DetailsVC
}

public final class MainModuleFactory: MainFactory {
    public init() {}
    
    public func makeStartModule() -> StartVC {
        let container = StartContainer()
        let contentView = StartCV()
        let viewModel = StartVM(coreDataManager: container.coreDataManager(),
                                sessionService: container.sessionService(),
                                useCases: (container.todosUseCase(),
                                           container.deleteTodoUseCase())
        )
        let viewController = StartVC(contentView: contentView, viewModel: viewModel)
        return viewController
    }
    
    public func makeDetailsmodule(delegate: ActionProtocol, todo: TodoRepresentable?) -> DetailsVC {
        let container = DetailsContainer()
        let contentView = DetailsCV()
        let viewModel = DetailsVM(delegate: delegate,
                                  coreDataManager: container.coreDataManager(),
                                  sessionService: container.sessionService(),
                                  todo: todo)
        let viewController = DetailsVC(contentView: contentView, viewModel: viewModel)
        return viewController
    }
}
