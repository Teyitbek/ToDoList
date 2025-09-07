import StartDI
import StartPresentation
import DetailsDI
import DetailsPresentation
import Domain
import Combine
import UIKit

public protocol MainFactory {
    func makeStartModule() -> StartVC
    func makeDetailsmodule(todo: TodoRepresentable?) -> DetailsVC
}

public final class MainModuleFactory: MainFactory {
    public init() {}
    
    public func makeStartModule() -> StartVC {
        let container = StartContainer()
        let contentView = StartCV()
        let viewModel = StartVM(sessionService: container.sessionService(),
                                useCases: (container.todosUseCase(),
                                           container.deleteTodoUseCase())
        )
        let viewController = StartVC(contentView: contentView, viewModel: viewModel)
        return viewController
    }
    
    public func makeDetailsmodule(todo: TodoRepresentable?) -> DetailsVC {
        let container = DetailsContainer()
        let contentView = DetailsCV()
        let viewModel = DetailsVM(sessionService: container.sessionService(), todo: todo)
        let viewController = DetailsVC(contentView: contentView, viewModel: viewModel)
        return viewController
    }
}
