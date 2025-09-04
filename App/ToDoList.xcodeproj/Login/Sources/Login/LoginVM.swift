import Combine
import LoginDomain

public protocol LoginViewModel {
    var configs: PassthroughSubject<Configs, Never>? { get set }
}

public typealias OnFinishedClosure = (() -> Void)

public final class LoginVM: LoginViewModel {
    public var configs: PassthroughSubject<Configs, Never>?
    public var onFinishedClosure: OnFinishedClosure?
    
    public init(configs: PassthroughSubject<Configs, Never>? = nil, onFinishedClosure: OnFinishedClosure? = nil) {
        self.configs = configs
        self.onFinishedClosure = onFinishedClosure
    }
}
