import AppContainer
import Combine
import Data
import Domain
import PincodeDomain
import PincodeData
import Factory

public final class PincodeContainer: ManagedContainer {
    public let manager: ContainerManager = ContainerManager()
    
//    public var googleClientID: Factory<String> {
//        Factory(self) {
//            AppContainer.shared.googleClientID()
//        }
//    }
    
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
    
    public var loginRemoteDataSource: Factory<LoginRemoteDataSource> {
        Factory(self) {
            LoginRemoteDataSourceImpl(client: AppContainer.shared.client())
        }
    }
    
//    public var socketService: Factory<SocketServicing> {
//        Factory(self) {
//            AppContainer.shared.socketService()
//        }
//    }
    
    public var loginRepository: Factory<LoginRepository> {
        Factory(self) {
            LoginRepositoryImpl(remoteDataSource: self.loginRemoteDataSource())
        }
    }
    
    public var loginUseCase: Factory<LoginUseCase> {
        Factory(self) {
            LoginUseCaseImpl(repository: self.loginRepository())
        }
    }
    
    public func setAccessToken(token: String) {
        AppContainer.shared.client().headers.set(.authBearerToken(token))
    }
    
    public init() {}
}
