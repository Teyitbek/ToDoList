import AppContainer
import Coordinator
import Combine
import Domain
import LaunchInstructor
import UIKit
import Base

public final class AppCoordinator: BaseCoordinator {
    private let coordinatorFactory: CoordinatorFactory
    private let container: AppContainer
    private let router: any Router
    private var option: DeepLinkOption?
    private var instructor: any Instructor
    private var cancellables = Set<AnyCancellable>()
    
    public init(router: Router, coordinatorFactory: CoordinatorFactory, instructor: any Instructor, container: AppContainer) {
        self.router = router
        self.coordinatorFactory = coordinatorFactory
        self.instructor = instructor
        self.container = container
        super.init()
    }
    
    override public func start() {
        runFlow()
        
        AppContainer.shared.inactivityTimeoutSubject()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] shouldGoToMainScreen in
                guard let self, shouldGoToMainScreen else { return }
                runMainFlow()
            }
            .store(in: &cancellables)
    }
    
    private func runFlow() {
        switch instructor.startOption() {
        case .splash: runSplashFlow()
        case .main: runMainFlow()
        }
    }
    
    private func runSplashFlow() {
        var coordinator = coordinatorFactory.makeSplashCoordinator(router: router)
        
        coordinator.finishFlow = { [weak self, weak coordinator] isSplashShown in
            self?.container.isSplashShown.register { isSplashShown }
            self?.instructor.isSplashShown = isSplashShown
            self?.runFlow()
            self?.removeDependency(coordinator)
        }
        
        addDependency(coordinator)
        coordinator.start()
    }
    
    private func runMainFlow() {
        var coordinator = coordinatorFactory.makeMainCoordinator(router: router)
        
        coordinator.finishFlow = { [weak self, weak coordinator] in
            self?.removeDependency(coordinator)
        }
//        coordinator.orderFlow = { [weak self] in
//            self?.runOrderFlow()
//        }
        addDependency(coordinator)
        coordinator.start()
    }
    
    private func runProductDetailsFlow(navigationController: NavigationController, product: ProductRepresentable, type: ProductDetailType) {
//        var coordinator = coordinatorFactory.makeProductDetailsCoordinator(router: router,
//                                                                           navigationController: navigationController,
//                                                                           product: product,
//                                                                           type: type)
//        coordinator.finishFlow = { [weak self, weak coordinator, weak router] in
//            router?.popModule()
//            self?.removeDependency(coordinator)
//        }
//        
//        addDependency(coordinator)
//        coordinator.start()
    }
    
    private func runOrderFlow() {
//        var coordinator = coordinatorFactory.makeCheckoutCoordinator(router: router, window: self.window)
//        
//        coordinator.finishFlow = { [weak self, weak coordinator] in
//            self?.runKioskFlow()
//            self?.removeDependency(coordinator)
//        }
//        addDependency(coordinator)
//        coordinator.start()
    }
}
