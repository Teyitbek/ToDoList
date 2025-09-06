import Data
import Domain
import Coordinator
import LaunchInstructor
import SplashCoordinator
import MainCoordinator
import UIKit
import Base

public final class AppCoordinatorFactory: CoordinatorFactory {
    public init() {}
    
    public func makeSplashCoordinator(router: any Router) -> any Coordinator & SplashCoordinatorResult {
        SplashCoordinator(router: router, factory: SplashFactoryImpl())
    }

    public func makeMainCoordinator(router: any Router) -> Coordinator & MainCoordinatorResult {
        MainCoordinator(router: router, factory: MainModuleFactory())
    }
}
