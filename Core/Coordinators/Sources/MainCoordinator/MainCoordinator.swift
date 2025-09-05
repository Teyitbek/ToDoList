import Combine
import StartPresentation
import Coordinator
import Domain
import UIKit
import Constants
import Base

public final class MainCoordinator: BaseCoordinator, MainCoordinatorResult {
    public var finishFlow: (() -> Void)?

    private let router: Router
    private let factory: MainFactory
    
    public init(router: Router, factory: MainFactory) {
        self.router = router
        self.factory = factory
    }
    
    override public func start() {
        showStartModule()
    }
    
    private func showStartModule() {
        let module = factory.makeStartModule()
        module.viewModel.onDetailsAction = showDetailsModule
        router.setRootModule(module, hideBar: false, hideNavigationBar: false)
    }
    
    private func showDetailsModule() {
        let module = factory.makeDetailsmodule()
        router.push(module, hideBar: true)
    }
}
