public protocol CoordinatorResult {
    var finishFlow: (() -> Void)? { get set }
}
