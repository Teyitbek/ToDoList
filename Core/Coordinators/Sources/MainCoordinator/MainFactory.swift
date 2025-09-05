import StartDI
import StartPresentation
import Domain
import Combine
import UIKit

public protocol MainFactory {
    func makeStartModule() -> StartVC
}

public final class MainModuleFactory: MainFactory {
    public init() {}
    
    public func makeStartModule() -> StartVC {
        let container = StartContainer()
        let contentView = StartCV()
        let viewModel = StartVM(sessionService: container.sessionService(), useCases: ())
        let viewController = StartVC(contentView: contentView, viewModel: viewModel)
        return viewController
    }
}
