import AuthCoordinator
import Coordinator

public final class AppCoordinatorFactory: CoordinatorFactory {
    public init() {}
    public func makeAuthCoordinator(router: any Router) -> Coordinator & AuthCoordinatorResult {
        AuthCoordinator(router: router, factory: AuthFactory())
    }
}
