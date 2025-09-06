import Coordinator
import Data
import Domain
import SplashCoordinator
import MainCoordinator
import UIKit
import Base

public protocol CoordinatorFactory {
    func makeSplashCoordinator(router: any Router) -> Coordinator & SplashCoordinatorResult
    func makeMainCoordinator(router: any Router) -> Coordinator & MainCoordinatorResult
}
