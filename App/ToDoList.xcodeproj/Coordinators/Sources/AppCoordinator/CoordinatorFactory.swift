import AuthCoordinator
import Coordinator

public protocol CoordinatorFactory {
    func makeAuthCoordinator(router: any Router) -> Coordinator & AuthCoordinatorResult
}
