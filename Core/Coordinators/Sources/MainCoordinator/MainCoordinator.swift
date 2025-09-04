import Combine
import Coordinator
import Domain
import UIKit
import Constants
import Base

public final class MainCoordinator: BaseCoordinator, MainCoordinatorResult {
    public var orderFlow: (() -> Void)?
    public var finishFlow: (() -> Void)?

    private let router: Router
    private let factory: MainFactory
    private var window: UIWindow!
    
    public init(router: Router, factory: MainFactory, window: UIWindow) {
        self.router = router
        self.factory = factory
        self.window = window
    }
    
    override public func start() {
        showStartModule()
    }
    
    private func showStartModule() {
        let module = factory.makeStartModule()
        self.window.rootViewController = module
        self.window.makeKeyAndVisible()
    }
}
