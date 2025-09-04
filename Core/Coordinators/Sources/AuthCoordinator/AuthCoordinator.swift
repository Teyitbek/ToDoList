import Coordinator
import UIKit
import Data
import Domain

public final class AuthCoordinator: BaseCoordinator, AuthCoordinatorResult {
    public var finishFlow: (() -> Void)?
    
    private let router: any Router
    private let factory: AuthenticationFactory
//    private let biometricService: BiometricService
    private let sessionService: SessionManaging
    public var window: UIWindow!
    
    public init(router: any Router, factory: AuthenticationFactory, sessionService: SessionManaging, window: UIWindow) {
        self.router = router
        self.factory = factory
//        self.biometricService = biometricService
        self.sessionService = sessionService
        self.window = window
    }
    
    override public func start() {
        showLogin()
    }
    
    private func showLogin() {
        let module = factory.makeLoginVC()
        module.viewModel.onFinish = finishFlow
        self.window.rootViewController = module
        self.window.makeKeyAndVisible()
    }
}
