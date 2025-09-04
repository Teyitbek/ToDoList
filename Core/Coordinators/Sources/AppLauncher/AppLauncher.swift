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
                                     container: container,
                                     window: window)
        coordinator.start()
        
        container.socketService().socketStatusSubject
            .receive(on: DispatchQueue.main)
            .sink { [weak self] status in
                guard let self, status == .connect else { return }
                if let device = container.printerManager().connectedDevice {
                    container.socketService().printerUpdated(with: device.toDict(isActive: true))
                }
            }
            .store(in: &cancellables)
    }
    
    public func logOut() {
        do {
            try container.sessionService().logout()
            coordinator.start()
        } catch {
            print("Failed")
        }
    }
    
    public func resetAll() {
        do {
            try container.sessionService().resetAll()
            coordinator.start()
        } catch {
            print("Failed")
        }
    }
}
