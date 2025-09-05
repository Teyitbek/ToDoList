import Combine
import Domain
import PincodeDomain
import Base

public protocol PincodeViewModel {
    var configs: PassthroughSubject<Configs, Never>? { get set }
    var sessionService: SessionManaging { get }
    var onSetAccessToken: ((String) -> Void)? { get set }
    var onFinish: CompletionClosure? { get set }
    var cancellables: Set<AnyCancellable> { get set }
    var loginTask: Task<Void,Never>? { get set }
    var location: Locationable? { get set }
    
    @MainActor
    func login(pincode: String)
    
}

public final class PincodeVM: ViewModel, PincodeViewModel {
    public var configs: PassthroughSubject<Configs, Never>?
    public var sessionService: SessionManaging
    public var loginUseCase: LoginUseCase
    
    public var onSetAccessToken: ((String) -> Void)?
    public var onFinish: CompletionClosure?
    public var cancellables = Set<AnyCancellable>()
    public var loginTask: Task<Void, Never>?
    public var pinCodeErrorSubject = PassthroughSubject<Error, Never>()
    public var location: Locationable?
    
    public init(
                configs: PassthroughSubject<Configs, Never>? = nil,
                sessionService: SessionManaging,
                loginUseCase: LoginUseCase) {
        self.configs = configs
        self.sessionService = sessionService
        self.loginUseCase = loginUseCase
        super.init()
    }
    
    @MainActor
    public func login(pincode: String) {
        activityIndicatorIsHiddenSubject.send(false)
        
        loginTask = Task {
            do {
                let response = try await loginUseCase.execute(with: LoginCredentials(pin: pincode))
//                try sessionService.save(accessToken: AccessToken(accessToken: response.accessToken))
//                try sessionService.save(user: response.data)
                onSetAccessToken?(response.accessToken)
                activityIndicatorIsHiddenSubject.send(true)
                onFinish?()
            } catch {
                pinCodeErrorSubject.send(error)
                activityIndicatorIsHiddenSubject.send(true)
            }
        }
    }
    
//    public func resetLocation() {
//        try? sessionService.resetAll()
//        onFinish?()
//    }
}
