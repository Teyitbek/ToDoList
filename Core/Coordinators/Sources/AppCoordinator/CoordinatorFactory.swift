import Coordinator
//import LocationCoordinator
import AuthCoordinator
import Data
import Domain
import SplashCoordinator
import MainCoordinator
//import CheckoutCoordinator
//import ProductDetailsCoordinator
import UIKit
import Base

public protocol CoordinatorFactory {
    func makeSplashCoordinator(router: any Router) -> Coordinator & SplashCoordinatorResult
    func makeAuthCoordinator(router: any Router, sessionService: SessionManaging) -> Coordinator & AuthCoordinatorResult
    func makeMainCoordinator(router: any Router) -> Coordinator & MainCoordinatorResult
//    func makeCheckoutCoordinator(router: any Router, window: UIWindow) -> Coordinator & CheckoutCoordinatorResult
//    func makeLocationCoordinator(router: any Router, window: UIWindow) -> Coordinator & LocationCoordinatorResult
//    func makeProductDetailsCoordinator(router: any Router, navigationController: NavigationController, product: ProductRepresentable, type: ProductDetailType) -> Coordinator & ProductDetailsCoordinatorResult
}
