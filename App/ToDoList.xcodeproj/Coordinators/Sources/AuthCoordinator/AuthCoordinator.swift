import Coordinator
import Login
import Splash

public final class AuthCoordinator: BaseCoordinator, AuthCoordinatorResult {
    public var finishFlow: (() -> Void)?
    
    private let router: any Router
    private let factory: AuthenticationFactory
    
    public init(router: any Router, factory: AuthenticationFactory) {
        self.router = router
        self.factory = factory
    }
    
    override public func start() {
        showLogin()
    }
    
    private func showLogin() {
        let module = LoginVC(contentView: LoginCV(), viewModel: LoginVM())
        router.push(module)
    }
    
    private func showSplash() {
        let module = SplashVC(contentView: SplashCV(), viewModel: SplashVM())
        router.setRootModule(module)
    }
}
