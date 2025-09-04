import Combine
import SplashDomain

public protocol SplashDelegate: AnyObject {
    func finishedFetchingData()
}

public typealias OnFinishedClosure = (() -> Void)?

public protocol SplashViewModel {
    associatedtype Configs
    var configs: Configs { get set }
}

public final class SplashVM: SplashViewModel {
    public var configs: PassthroughSubject<Configs, Never>?
    public var onFinishedClosure: OnFinishedClosure?
    public weak var delegate: SplashDelegate?
    
    public init(onFinished: OnFinishedClosure? = nil, delegate: SplashDelegate? = nil, configs: PassthroughSubject<Configs, Never>? = nil) {
        self.onFinishedClosure = onFinished
        self.delegate = delegate
        self.configs = configs
    }
    
    public func fetchData() {
        self.delegate?.finishedFetchingData()
    }
}
