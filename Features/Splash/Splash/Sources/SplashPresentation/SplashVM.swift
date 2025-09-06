import Combine
import Domain
import SplashData
import SplashDomain
import Base
import Foundation

public protocol SplashViewModel {
    var onFinish: ((Bool) -> Void)? { get set }
}

public typealias UseCases = ()

public final class SplashVM: ViewModel, SplashViewModel {
    public var onFinish: ((Bool) -> Void)?
    
    public var appType: String
    public var appVersion: String
    public var useCases: UseCases
    public var sessionService: any SessionManaging
    public var appInit: CurrentValueSubject<AppInit, Never>
    
    public init(appType: String,
                appVersion: String,
                useCases: UseCases,
                sessionService: SessionManaging,
                appInitSubject: CurrentValueSubject<AppInit,Never>) {
        self.appType = appType
        self.appVersion = appVersion
        self.useCases = useCases
        self.sessionService = sessionService
        self.appInit = appInitSubject
        super.init()
    }
}
