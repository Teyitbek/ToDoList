import AppContainer
import Combine
import Data
import Domain
import Factory
import StartDomain
import StartData

public final class StartContainer: ManagedContainer {
    public let manager: ContainerManager = ContainerManager()
    
    public var labelsSubject: Factory<CurrentValueSubject<[String:String], Never>> {
        Factory(self) {
            AppContainer.shared.labelsSubject()
        }
    }
    
//    public var saveSelectedLanguageUseCase: Factory<SaveSelectedLanguageUseCase> {
//        Factory(self) {
//            AppContainer.shared.saveSelectedLanguageUseCase()
//        }
//    }
//    
//    public var getRemoteLanguagesUseCase: Factory<GetRemoteLanguagesUseCase> {
//        Factory(self) {
//            AppContainer.shared.getRemoteLanguagesUseCase()
//        }
//    }
    
    public var bannerDataSource: Factory<BannerRemoteDataSource> {
        Factory(self) {
            BannerRemoteDataSourceImpl(client: AppContainer.shared.client())
        }
        .singleton
    }
    
    public var bannerRepository: Factory<BannerRepository> {
        Factory(self) {
            BannerRepositoryImpl(remoteDataSource: self.bannerDataSource())
        }
        .singleton
    }
    
//    public var getBannersUseCase: Factory<GetBannersUseCase> {
//        Factory(self) {
//            GetBannersUseCaseImpl(repository: self.bannerRepository())
//        }
//        .singleton
//    }
    
//    public var getLabelsUseCase: Factory<GetLabelsUseCase> {
//        Factory(self) {
//            AppContainer.shared.getLabelsUseCase()
//        }
//    }
//    
//    public var saveLabelsUseCase: Factory<SaveLabelsUseCase> {
//        Factory(self) {
//            AppContainer.shared.saveLabelsUseCase()
//        }
//    }
//    
//    public var socketService: Factory<SocketServicing> {
//        Factory(self) {
//            AppContainer.shared.socketService()
//        }
//    }
    
    public var sessionService: Factory<SessionManaging> {
        Factory(self) {
            AppContainer.shared.sessionService()
        }
    }
    
//    public var printerManager: Factory<PrinterManager> {
//        Factory(self) {
//            AppContainer.shared.printerManager()
//        }
//    }
    
    public init() {}
}
