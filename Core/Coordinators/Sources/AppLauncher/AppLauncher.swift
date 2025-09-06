import AppContainer
import AppCoordinator
import Coordinator
import Combine
import LaunchInstructor
import Domain
import UIKit.UINavigationController

final public class AppLauncher {
    private var instructor: any Instructor
    private let navigationController = UINavigationController()
    private let container: AppContainer
    public var window: UIWindow!
    public var coordinator: AppCoordinator!
    var cancellables: Set<AnyCancellable> = []
    
    public init(with window: UIWindow, container: AppContainer) {
        self.window = window
        self.instructor = LaunchInstructor(sessionService: container.sessionService(), isSplashShown: container.isSplashShown())
        self.container = container
    }
    
    public func launch() {
        navigationController.navigationBar.isHidden = true
        window.rootViewController = navigationController
        let router = AppRouter(rootController: navigationController)
        let appCoordinatorFactory = AppCoordinatorFactory()
        coordinator = AppCoordinator(router: router,
                                     coordinatorFactory: appCoordinatorFactory,
                                     instructor: instructor,
                                     container: container)
        coordinator.start()
    }
}
