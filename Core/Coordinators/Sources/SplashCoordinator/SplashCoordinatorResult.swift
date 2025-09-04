public protocol SplashCoordinatorResult {
    var finishFlow: ((_ isSplashCompleted: Bool) -> Void)? { get set }
    var onUnauthorizedFinish: ((_ isSplashCompleted: Bool) -> Void)? { get set }
}
