import AppContainer
import Combine
import Data
import Domain
import Factory
import SplashData
import SplashDomain

public final class SplashContainer: ManagedContainer {
    public let manager: ContainerManager = ContainerManager()
    
    public var appType: Factory<String> {
        Factory(self) {
            AppContainer.shared.appType()
        }
    }
    
    public var appVersion: Factory<String> {
        Factory(self) {
            AppContainer.shared.appVersion()
        }
    }
    
    
    public var sessionService: Factory<SessionManaging> {
        Factory(self) {
            AppContainer.shared.sessionService()
        }
    }
    
    public var labelsSubject: Factory<CurrentValueSubject<[String:String], Never>> {
        Factory(self) {
            AppContainer.shared.labelsSubject()
        }
    }
    
    public var deviceUIDRemoteDataSource: Factory<DeviceUIDDataSource> {
        Factory(self) {
            DeviceUIDDataSourceImpl(client: AppContainer.shared.client())
        }
    }
    
    public var deviceUIDUseCase: Factory<GetDeviceUIDUseCase> {
        Factory(self) {
            GetDeviceUIDUseCaseImpl(repository: self.deviceUIDRepository())
        }
    }
    
    public var deviceUIDRepository: Factory<GetDeviceUIDRepository> {
        Factory(self) {
            GetDeviceUIDRepositoryImpl(dataSource: self.deviceUIDRemoteDataSource())
        }
    }
    
    public var appInitUseCase: Factory<String> {
        Factory(self) {
            ""
        }
    }
    
    public var appInit: Factory<CurrentValueSubject<AppInit,Never>> {
        Factory(self) {
            AppContainer.shared.appInit()
        }
    }
    
    public init() {}
    
    public func setDeviceUID(deviceUID: String) {
        AppContainer.shared.client().headers.set("deviceUid", deviceUID)
        AppContainer.shared.deviceUid.register { deviceUID }
    }
}

