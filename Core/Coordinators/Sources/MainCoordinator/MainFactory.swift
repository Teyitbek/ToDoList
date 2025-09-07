import StartDI
import StartPresentation
import DetailsDI
import DetailsPresentation
import Domain
import Combine
import UIKit

public protocol MainFactory {
    func makeStartModule() -> StartVC
    func makeDetailsmodule() -> DetailsVC
}

public final class MainModuleFactory: MainFactory {
    public init() {}
    
    public func makeStartModule() -> StartVC {
        let container = StartContainer()
        let contentView = StartCV()
        let viewModel = StartVM(sessionService: container.sessionService(),
                                todosUseCase: container.todosUseCase())
        let viewController = StartVC(contentView: contentView, viewModel: viewModel)
        return viewController
    }
    
    public func makeDetailsmodule() -> DetailsVC {
        let container = DetailsContainer()
        let contentView = DetailsCV()
        let viewModel = DetailsVM(sessionService: container.sessionService(), useCases: ())
        let viewController = DetailsVC(contentView: contentView, viewModel: viewModel)
        return viewController
    }
}
