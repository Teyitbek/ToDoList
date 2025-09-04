import Combine
import Domain
import SplashData
import SplashDomain
import Base
import Foundation

public protocol SplashViewModel {
    var appType: String { get }
    var appVersion: String { get }
    var useCases: UseCases { get }
    var indexTask: Task<Void,Never>? { get set }
    var deviceUIDTask: Task<Void,Never>? { get set }
    var onFinish: ((Bool) -> Void)? { get set }
    var onUnauthorizedFinish: ((Bool) -> Void)? { get set }
    var cancellables: Set<AnyCancellable> { get set }
    var sessionService: SessionManaging { get }
    var indexResultSubject: PassthroughSubject<UserRepresentable, Never> { get }
    var onSetDeviceUID: ((String) -> Void)? { get set }
    var appInit: CurrentValueSubject<AppInit, Never> { get }
    var appInitTask: Task<Void, Never>? { get set }

//    func getDeviceUIDIfNeeded() async throws -> String
}

public typealias UseCases = (deviceUid: GetDeviceUIDUseCase, appInit: GetAppInitUseCase, index: GetAccountIndexUseCase)

public final class SplashVM: ViewModel, SplashViewModel {
    public var deviceUIDTask: Task<Void, Never>?
    public var onSetDeviceUID: ((String) -> Void)?
    public var appType: String
    public var appVersion: String
    public var indexTask: Task<Void, Never>?
    public var appInitTask: Task<Void, Never>?
    public var useCases: UseCases
    public var onFinish: ((Bool) -> Void)?
    public var onUnauthorizedFinish: ((Bool) -> Void)?
    public var indexResultSubject = PassthroughSubject<UserRepresentable, Never>()
    public var cancellables = Set<AnyCancellable>()
    public var sessionService: any SessionManaging
    public var appInit: CurrentValueSubject<AppInit, Never>
    
    public init(labelsSubjct: CurrentValueSubject<[String:String], Never>,
                appType: String,
                appVersion: String,
                useCases: UseCases,
                sessionService: SessionManaging,
                appInitSubject: CurrentValueSubject<AppInit,Never>) {
        self.appType = appType
        self.appVersion = appVersion
        self.useCases = useCases
        self.sessionService = sessionService
        self.appInit = appInitSubject
        super.init(labelsSubject: labelsSubjct)
    }
    
//    public func getDeviceUIDIfNeeded() async throws -> String {
//        if let deviceUID = try sessionService.retrieveDeviceUID() {
//            return deviceUID
//        } else {
//            return try await useCases.deviceUid.execute(appType: appType, appVersion: appVersion)
//        }
//    }
    
//    public func fetchAccountIndexIfPossible() async throws -> UserRepresentable? {
//        if sessionService.accessTokenIsAvailable {
//            return try await self.useCases.index.execute()
//        } else {
//            return nil
//        }
//    }
    
    @MainActor
    func checksAndFetchRequiredData() {
//        activityIndicatorIsHiddenSubject.send(false)
//        deviceUIDTask = Task {
//            do {
//                let deviceUid = try await getDeviceUIDIfNeeded()
//                onSetDeviceUID?(deviceUid)
//                try sessionService.save(deviceUID: deviceUid)
//                
//                if let accountIndexResponse = try await fetchAccountIndexIfPossible() {
//                    try sessionService.save(user: accountIndexResponse)
//                }
//                
//                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
//                    self.onFinish?(true)
//                    self.activityIndicatorIsHiddenSubject.send(true)
//                })
//            } catch {
//                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
//                    self.activityIndicatorIsHiddenSubject.send(true)
//                    self.errorSubject.send(error)
//                    self.deleteAccessTokenAndAccount()
//                    self.onUnauthorizedFinish?(true)
//                })
//            }
//        }
    }
    
    func deleteAccessTokenAndAccount() {
//        do {
//            try sessionService.deleteAccessToken()
//        } catch {
//            errorSubject.send(error)
//        }
    }
}
