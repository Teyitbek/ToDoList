public protocol AuthCoordinatorResult {
    var finishFlow: (() -> Void)? { get set }
}
