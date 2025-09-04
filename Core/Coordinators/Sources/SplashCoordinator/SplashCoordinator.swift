import Coordinator
import UIKit
import Data
import Domain
import Factory

public final class SplashCoordinator: BaseCoordinator, SplashCoordinatorResult {
    public var onUnauthorizedFinish: ((Bool) -> Void)?
    public var finishFlow: ((_ isSplashCompleted: Bool) -> Void)?
    
    private let router: Router
    private let factory: SplashFactory
//    public var window: UIWindow!
    
    public init(router: Router, factory: SplashFactory) {
        self.router = router
        self.factory = factory
    }
    
    override public func start() {
        showSplash()
    }
    
    private func showSplash() {
        let module = factory.makeSplashModule()
        module.viewModel.onFinish = finishFlow
        router.setRootModule(module)
    }
}
