import Combine
import Domain
import UIKit

public protocol ViewModelRepresentable {
    var errorSubject: PassthroughSubject<Error, Never> { get set }
    var activityIndicatorIsHiddenSubject: PassthroughSubject<Bool, Never> { get set }
    var networkStatusSubject: PassthroughSubject<NetworkStatus, Never>? { get set }
}

open class ViewModel: ViewModelRepresentable {
    public var errorSubject = PassthroughSubject<any Error, Never>()
    public var activityIndicatorIsHiddenSubject = PassthroughSubject<Bool, Never>()
    public var networkStatusSubject: PassthroughSubject<NetworkStatus, Never>?
    public var messageSubject = PassthroughSubject<String?, Never>()
    
    public init(networkStatusSubject: PassthroughSubject<NetworkStatus, Never>? = nil) {
        self.networkStatusSubject = networkStatusSubject
    }
    
    deinit {
        print("===> \(type(of: self)) is deinited")
    }
}
