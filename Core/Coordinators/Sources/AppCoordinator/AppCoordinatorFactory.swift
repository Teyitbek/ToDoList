import Data
import AuthCoordinator
import Domain
import Coordinator
import LaunchInstructor
import SplashCoordinator
import MainCoordinator
//import CheckoutCoordinator
//import ProductDetailsCoordinator
import UIKit
import Base

public final class AppCoordinatorFactory: CoordinatorFactory {
    public init() {}
    
    public func makeSplashCoordinator(router: any Router) -> any Coordinator & SplashCoordinatorResult {
        SplashCoordinator(router: router, factory: SplashFactoryImpl())
    }
    
    public func makeAuthCoordinator(router: any Router, sessionService: SessionManaging) -> Coordinator & AuthCoordinatorResult {
        AuthCoordinator(router: router, factory: AuthFactory(), sessionService: sessionService)
    }

    public func makeMainCoordinator(router: any Router) -> Coordinator & MainCoordinatorResult {
        MainCoordinator(router: router, factory: MainModuleFactory())
    }
//    
//    public func makeCheckoutCoordinator(router: any Router, window: UIWindow) -> Coordinator & CheckoutCoordinatorResult {
//        CheckoutCoordinator(router: router, factory: CheckoutModuleFactory(), window: window)
//    }
//    
//    public func makeProductDetailsCoordinator(router: any Router, navigationController: NavigationController, product: ProductRepresentable, type: ProductDetailType) -> Coordinator & ProductDetailsCoordinatorResult {
//        ProductDetailsCoordinator(router: router,
//                                  factory: ProductDetailsModuleFactory(),
//                                  product: product,
//                                  type: type,
//                                  navigationController: navigationController)
//    }
}
