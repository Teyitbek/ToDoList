import AppCoordinator
import Coordinator
import Factory
import LaunchInstructor
import Session
import UIKit.UINavigationController
import UIKit.UIWindow

public final class AppContainer: SharedContainer {
    public static var shared = AppContainer()
    
    public var manager = ContainerManager()
    
    var rootViewController: Factory<UINavigationController> {
        self { UINavigationController() }
            .singleton
    }
    
    public var window: Factory<UIWindow> {
        self {
            let window = UIWindow()
            window.rootViewController = self.rootViewController()
            window.makeKeyAndVisible()
            return window
        }
        .singleton
    }
    
    var sessionManager: Factory<SessionProtocol> {
        self { Session() }.cached
    }
    
    var instructor: Factory<any Instructor> {
        self { LaunchInstructor(session: self.sessionManager()) }
    }
    
    public var coordinator: Factory<Coordinator> {
        self {
            let router = AppRouter(rootController: self.rootViewController())
            let appCoordinatorFactory = AppCoordinatorFactory()
            return AppCoordinator(
                router: router,
                coordinatorFactory: appCoordinatorFactory,
                instructor: self.instructor()
            )
        }
        .singleton
    }
}
