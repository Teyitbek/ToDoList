import Coordinator
import LaunchInstructor

public final class AppCoordinator: BaseCoordinator {
    private let coordinatorFactory: CoordinatorFactory
    private let router: any Router
    private var option: DeepLinkOption?
    private var instructor: any Instructor
    
    public init(router: any Router, coordinatorFactory: CoordinatorFactory, instructor: any Instructor) {
        self.router = router
        self.coordinatorFactory = coordinatorFactory
        self.instructor = instructor
        super.init()
    }
    
    override public func start() {
        runFlow()
    }
    
    override public func handle(_ option: DeepLinkOption?) {
        self.option = option
        
        childCoordinators.forEach { coordinator in
            coordinator.handle(option)
        }
    }

    private func runFlow() {
        switch instructor.startOption() {
        case .splash: runSplashFlow()
        case .auth: runAuthFlow()
        case .main: runMainFlow()
        }
    }
    
    private func runSplashFlow() {
        var coordinator = coordinatorFactory.makeAuthCoordinator(router: router)
        
        coordinator.finishFlow = { [weak self, weak coordinator] in
            self?.runFlow()
            self?.removeDependency(coordinator)
        }
        
        addDependency(coordinator)
        coordinator.start()
    }
    
    private func runAuthFlow() {
        var coordinator = coordinatorFactory.makeAuthCoordinator(router: router)
        
        coordinator.finishFlow = { [weak self, weak coordinator] in
            self?.resetOption()
            self?.runFlow()
            self?.removeDependency(coordinator)
        }
        
        addDependency(coordinator)
        coordinator.start()
        coordinator.handle(option)
    }
    
    private func runMainFlow(with options: DeepLinkOption? = nil) {
    }
    
    // Call this function on each finish flow block
    private func resetOption() {
        option = nil
    }
}
