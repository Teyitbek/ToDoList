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
//    public var window: UIWindow!
    
    public init(router: Router, coordinatorFactory: CoordinatorFactory, instructor: any Instructor, container: AppContainer) {
        self.router = router
        self.coordinatorFactory = coordinatorFactory
        self.instructor = instructor
        self.container = container
//        self.window = window
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
        case .auth: runAuthFlow()
        case .location: runLocationFlow()
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
    
    private func runAuthFlow() {
//        var coordinator = coordinatorFactory.makeAuthCoordinator(router: router, sessionService: container.sessionService())
//        
//        coordinator.finishFlow = { [weak self, weak coordinator] in
//            self?.runFlow()
//            self?.removeDependency(coordinator)
//        }
//        
//        addDependency(coordinator)
//        coordinator.start()
    }
    
    private func runLocationFlow() {
//        var coordinator = coordinatorFactory.makeLocationCoordinator(router: router, window: window)
//        
//        coordinator.finishFlow = { [weak self, weak coordinator] in
//            self?.container.isSplashShown.register { false }
//            self?.instructor.isSplashShown = false
//            self?.runFlow()
//            self?.removeDependency(coordinator)
//        }
//        
//        addDependency(coordinator)
//        coordinator.start()
    }
    
    private func runMainFlow() {
        var coordinator = coordinatorFactory.makeMainCoordinator(router: router)
        
        coordinator.finishFlow = { [weak self, weak coordinator] in
            self?.removeDependency(coordinator)
        }
        coordinator.orderFlow = { [weak self] in
            self?.runOrderFlow()
        }
//        coordinator.onEditProductDetails = { [weak self] (navigationController, orderItemId, productDetails) in
//            guard let self, let product = productDetails.makeProduct() else { return }
//            runProductDetailsFlow(navigationController: navigationController, product: product, type: .edit(orderItemId, productDetails))
//        }
        
//        coordinator.onProductDetails = runProductDetailsFlow
        
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
