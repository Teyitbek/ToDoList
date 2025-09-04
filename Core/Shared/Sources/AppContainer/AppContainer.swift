import Combine
import UIKit
import Data
import Domain
import Factory
import Foundation
import RealHTTP
import Session

public final class AppContainer: SharedContainer {
    public static let shared = AppContainer()
    
    public let manager = ContainerManager()
    
    public var appInit: Factory<CurrentValueSubject<AppInit, Never>> {
        Factory(self) {
            CurrentValueSubject<AppInit, Never>(.init())
        }
        .singleton
    }
    
    public var userSubject: Factory<PassthroughSubject<UserRepresentable, Never>> {
        Factory(self) {
            PassthroughSubject<UserRepresentable, Never>()
        }
        .singleton
    }
    
    public var isSplashShown: Factory<Bool> {
        Factory(self) {
            false
        }
        .singleton
    }
    
    public var labelsSubject: Factory<CurrentValueSubject<[String:String], Never>> {
        Factory(self) {
            CurrentValueSubject<[String:String], Never>([:])
        }
        .singleton
    }
    
    public var cartSubject: Factory<CurrentValueSubject<Domain.Cart, Never>> {
        Factory(self) {
            CurrentValueSubject<Domain.Cart, Never>(.init())
        }
        .singleton
    }
    
    public var sessionService: Factory<SessionManaging> {
        Factory(self) {
            SessionService(useCases: (
                    self.saveLocationUseCase(),
                    self.retrieveLocationUseCase(),
                    self.deleteLocationUseCase(),
                    self.saveAccessTokenUseCase(),
                    self.saveUserUseCase(),
                    self.retrieveUserUseCase(),
                    self.retrieveAccessTokenUseCase(),
                    self.deleteAccessTokenUseCase(),
                    self.deleteUserUseCase(),
                    self.localSaveDeviceUIDUseCase(),
                    self.localRetrieveDeviceUIDUseCase(),
                    self.localDeleteDeviceUIDUseCase(),
                    self.savePrinterDeviceUseCase(),
                    self.getPrinterDeviceUseCase(),
                    self.deletePrinterDeviceUseCase(),
                    self.saveTerminalDeviceUseCase(),
                    self.getTerminalDeviceUseCase(),
                    self.deleteTerminalDeviceUseCase()
                )
            )
        }.singleton
    }
    
    public var baseAPIURL: Factory<String> {
        Factory(self) {
            ""
        }.singleton
    }
    
    public var appType: Factory<String> {
        Factory(self) {
            "ios-kiosk"
        }.singleton
    }
    
    public var appVersion: Factory<String> {
        Factory(self) {
            ""
        }.singleton
    }
    
    public var appBuild: Factory<String> {
        Factory(self) {
            ""
        }
        .singleton
    }
    
    public var deviceUid: Factory<String> {
        Factory(self) {
            ""
        }
        .singleton
    }
    
    public var deviceName: Factory<String> {
        Factory(self) {
            DeviceInfo.userDefinedName
        }.singleton
    }
    
    public var deviceModel: Factory<String> {
        Factory(self) {
            DeviceInfo.modelName
        }.singleton
    }
    
    public var googleClientID: Factory<String> {
        Factory(self) {
            ""
        }.singleton
    }
    
    public var stripeRedirectURL: Factory<String> {
        Factory(self) {
            ""
        }
        .singleton
    }
    
    public var socketURL: Factory<String> {
        Factory(self) {
            ""
        }
        .singleton
    }
    
    public var applePayMerchantID: Factory<String> {
        Factory(self) {
            ""
        }
        .singleton
    }
    
    public var applePayMerchantCountryCode: Factory<String> {
        Factory(self) {
            ""
        }
        .singleton
    }
    
    public var biometricService: Factory<BiometricService> {
        Factory(self) {
            DefaultBiometricService()
        }
        .singleton
    }
    
    public var socketService: Factory<SocketServicing> {
        Factory(self) {
            SocketService(session: self.sessionService(), socketURL: self.socketURL(), appType: self.appType(), appVersion: self.appVersion(), deviceUID: self.deviceUid())
        }
        .singleton
    }
    
    public var inactivityTimerService: Factory<InactivityTimerService> {
        Factory(self) {
            InactivityTimerService(inactivityTimeoutSubject: self.inactivityTimeoutSubject())
        }
        .singleton
    }
    
    public var terminalService: Factory<TerminalService> {
        Factory(self) {
            TerminalService(getDeviceSecretUseCase: self.getRemoteDeviceSecretUseCase(),
                            saveDeviceSecretUseCase: self.saveDeviceSecretUseCase(),
                            session: self.sessionService(),
                            baseURL: self.baseAPIURL())
        }
        .singleton
    }
    
    public var printerManager: Factory<PrinterManager> {
        Factory(self) {
            PrinterManager(session: self.sessionService(), socketService: self.socketService())
        }
        .singleton
    }
    
    public var logOutSubject: Factory<PassthroughSubject<Bool, Never>> {
        Factory(self) {
            PassthroughSubject<Bool, Never>()
        }
        .singleton
    }
    
    public var deleteLocationSubject: Factory<PassthroughSubject<Bool, Never>> {
        Factory(self) {
            PassthroughSubject<Bool, Never>()
        }
        .singleton
    }
    
    public var inactivityTimeoutSubject: Factory<PassthroughSubject<Bool, Never>> {
        Factory(self) {
            PassthroughSubject<Bool, Never>()
        }
        .singleton
    }
    
    public var client: Factory<HTTPClient> {
        Factory(self) {
            let client = HTTPClient(baseURL: URL(string: self.baseAPIURL()))
            client.validators.append(DeviceValidator(deleteLocationSubject: self.deleteLocationSubject()))
            client.validators.append(UserValidator(logOutClosure: self.logOutSubject()))
            client.validators.append(ResponseLogValidator())
            client.validators.append(ResponseMessageValidator())
            
            if let accessToken = self.sessionService().accessToken {
                client.headers.set(.authBearerToken(accessToken))
            }
            
            if let location = self.sessionService().retrieveLocation() {
                client.headers.set("locationId", "\(location.id)")
            }
            
            if let languageId = self.selectedLanguageSubject().value?.id {
                client.headers.set("languageId", languageId)
            }
            
            client.headers.set("appType", self.appType())
            client.headers.set("appVersion", self.appVersion())
            client.headers.set("deviceUid", self.deviceUid())
            client.headers.set("deviceName", self.deviceName())
            client.headers.set("deviceModel", self.deviceModel())
            return client
        }
        .singleton
    }
    
    public var userDefaultsService: Factory<PersistentStorage> {
        Factory(self) {
            UserDefaultsService()
        }
        .singleton
    }
    
    public var keychainServiceAuth: Factory<any SecureStorage> {
        Factory(self) {
            KeychainService(identifier: "com.ToDoList.auth", accessibility: .whenUnlocked)
        }
        .singleton
    }
    
    public var keychainServiceUser: Factory<any SecureStorage> {
        Factory(self) {
            KeychainService(identifier: "com.ToDoList.user", accessibility: .whenUnlocked)
        }
        .singleton
    }
    
    public var saveAccessTokenDataSource: Factory<AccessTokenKeychainDataSource> {
        Factory(self) {
            AccessTokenKeychainDataSourceImpl(service: self.keychainServiceAuth())
        }
        .singleton
    }
    
    public var saveLocationDataSource: Factory<LocationKeychainDataSource> {
        Factory(self) {
            LocationKeychainDataSourceImpl(service: self.keychainServiceAuth())
        }
        .singleton
    }
    
    public var accessTokenRepository: Factory<AccessTokenRepository> {
        Factory(self) {
            AccessTokenRepositoryImpl(dataSource: self.saveAccessTokenDataSource())
        }
        .singleton
    }
    
    public var locationRepository: Factory<LocationRepository> {
        Factory(self) {
            LocationRepositoryImpl(dataSource: self.saveLocationDataSource())
        }
        .singleton
    }
    
    public var saveUserDataSource: Factory<UserKeychainDataSource> {
        Factory(self) {
            UserKeychainDataSourceImpl(service: self.keychainServiceUser())
        }
        .singleton
    }
    
    public var userRepository: Factory<UserRepository> {
        Factory(self) {
            UserRepositoryImpl(dataSource: self.saveUserDataSource())
        }
        .singleton
    }
    
    public var saveAccessTokenUseCase: Factory<SaveAccessTokenUseCase> {
        Factory(self) {
            SaveAccessTokenUseCaseImpl(repository: self.accessTokenRepository())
        }
        .singleton
    }
    
    public var saveLocationUseCase: Factory<SaveLocationUseCase> {
        Factory(self) {
            SaveLocationUseCaseImpl(repository: self.locationRepository())
        }
        .singleton
    }
    
    public var saveUserUseCase: Factory<SaveUserUseCase> {
        Factory(self) {
            SaveUserUseCaseImpl(repository: self.userRepository())
        }
        .singleton
    }
    
    public var retrieveUserUseCase: Factory<RetrieveUserUseCase> {
        Factory(self) {
            RetrieveUserUseCaseImpl(repository: self.userRepository())
        }
        .singleton
    }
    
    public var deleteAccessTokenUseCase: Factory<DeleteAccessTokenUseCase> {
        Factory(self) {
            DeleteAccessTokenUseCaseImpl(repository: self.accessTokenRepository())
        }
        .singleton
    }
    
    public var deleteLocationUseCase: Factory<DeleteLocationUseCase> {
        Factory(self) {
            DeleteLocationUseCaseImpl(repository: self.locationRepository())
        }
        .singleton
    }
    
    public var retrieveAccessTokenUseCase: Factory<RetrieveAccessTokenUseCase> {
        Factory(self) {
            RetrieveAccessTokenUseCaseImpl(repository: self.accessTokenRepository())
        }
        .singleton
    }
    
    public var retrieveLocationUseCase: Factory<RetrieveLocationUseCase> {
        Factory(self) {
            RetrieveLocationUseCaseImpl(repository: self.locationRepository())
        }
        .singleton
    }
    
    public var deleteUserUseCase: Factory<DeleteUserUseCase> {
        Factory(self) {
            DeleteUserUseCaseImpl(repository: self.userRepository())
        }
        .singleton
    }
    
    public var selectedLanguageSubject: Factory<CurrentValueSubject<LanguageRepresentable?, Never>> {
        Factory(self) {
            do {
                let language = try self.getSelectedLanguageUseCase().execute()
                return CurrentValueSubject<LanguageRepresentable?, Never>(language)
            } catch {
                return CurrentValueSubject<LanguageRepresentable?, Never>(nil)
            }
        }
        .singleton
    }
}

// MARK: - Categories

extension AppContainer {
    // Remote
    public var languageRemoteDataSource: Factory<LanguagesRemoteDataSource> {
        Factory(self) {
            LanguagesRemoteDataSourceImpl(client: AppContainer.shared.client())
        }
    }
    
    public var languageLocalDataSource: Factory<LanguagesLocalDataSource> {
        Factory(self) {
            LanguagesLocalDataSourceImpl(service: AppContainer.shared.userDefaultsService())
        }
    }
    
    public var languageRemoteRepository: Factory<LanguagesRemoteRepository> {
        Factory(self) {
            LanguagesRemoteRepositoryImpl(remoteDataSource: self.languageRemoteDataSource())
        }
    }
    
    public var languageLocalRepository: Factory<LanguagesLocalRepository> {
        Factory(self) {
            LanguagesLocalRepositoryImpl(localDataSource: self.languageLocalDataSource())
        }
    }
    
    public var getRemoteLanguagesUseCase: Factory<GetRemoteLanguagesUseCase> {
        Factory(self) {
            GetRemoteLanguagesUseCaseImpl(repository: self.languageRemoteRepository())
        }
    }
    
    // Local
    public var getLanguagesUseCase: Factory<GetLanguagesUseCase> {
        Factory(self) {
            GetLanguagesUseCaseImpl(repository: self.languageLocalRepository())
        }
    }
    
    public var saveLanguagesUseCase: Factory<SaveLanguagesUseCase> {
        Factory(self) {
            SaveLanguagesUseCaseImpl(repository: self.languageLocalRepository())
        }
    }
    
    public var deleteLocalLanguagesUseCase: Factory<DeleteLanguagesUseCase> {
        Factory(self) {
            DeleteLanguagesUseCaseImpl(repository: self.languageLocalRepository())
        }
        .singleton
    }
    
    // Selected local
    public var getSelectedLanguageUseCase: Factory<GetSelectedLanguageUseCase> {
        Factory(self) {
            GetSelectedLanguageUseCaseImpl(repository: self.languageLocalRepository())
        }
        .singleton
    }
    
    public var saveSelectedLanguageUseCase: Factory<SaveSelectedLanguageUseCase> {
        Factory(self) {
            SaveSelectedLanguageUseCaseImpl(repository: self.languageLocalRepository())
        }
        .singleton
    }
    
    public var deleteSelectedLanguageUseCase: Factory<DeleteSelectedLanguageUseCase> {
        Factory(self) {
            DeleteSelectedLanguageUseCaseImpl(repository: self.languageLocalRepository())
        }
        .singleton
    }
    
    // Labels
    public var getLabelsUseCase: Factory<GetLabelsUseCase> {
        Factory(self) {
            GetLabelsUseCaseImpl(repository: self.languageRemoteRepository())
        }
    }
    
    public var saveLabelsUseCase: Factory<SaveLabelsUseCase> {
        Factory(self) {
            SaveLabelsUseCaseImpl(repository: self.languageLocalRepository())
        }
    }
}

// MARK: - DeviceUID

extension AppContainer {
    public var localDeviceUIDDataStore: Factory<DeviceUIDUserDefaultsDataSource> {
        Factory(self) {
            DeviceUIDUserDefaultsDataSourceImpl(service: self.userDefaultsService())
        }
        .singleton
    }
    
    public var localDeviceUIDRepository: Factory<DeviceUIDRepository> {
        Factory(self) {
            DeviceUIDRepositoryImpl(dataSource: self.localDeviceUIDDataStore())
        }
        .singleton
    }
    
    public var localSaveDeviceUIDUseCase: Factory<SaveDeviceUIDUseCase> {
        Factory(self) {
            SaveDeviceUIDUseCaseImp(repository: self.localDeviceUIDRepository())
        }
        .singleton
    }
    
    public var localRetrieveDeviceUIDUseCase: Factory<RetrieveDeviceUIDUseCase> {
        Factory(self) {
            RetrieveDeviceUIDUseCaseImp(repository: self.localDeviceUIDRepository())
        }
        .singleton
    }
    
    public var localDeleteDeviceUIDUseCase: Factory<DeleteDeviceUIDUseCase> {
        Factory(self) {
            DeleteDeviceUIDUseCaseImp(repository: self.localDeviceUIDRepository())
        }
        .singleton
    }
}

// MARK: - Kitchen

extension AppContainer {
    public var profileRemoteDataSource: Factory<KitchenRemoteDataSource> {
        Factory(self) {
            KitchenRemoteDataSourceImpl(client: AppContainer.shared.client())
        }
        .singleton
    }
    
    public var profileRepository: Factory<LogOutRepository> {
        Factory(self) {
            LogOutRepositoryImpl(remoteDataSource: self.profileRemoteDataSource())
        }
        .singleton
    }
    
    public var profileLogOutUseCase: Factory<LogOutUseCase> {
        Factory(self) {
            LogOutUseCaseImpl(repository: self.profileRepository())
        }
        .singleton
    }
}

// MARK: - App init
extension AppContainer {
    public var appRemoteDataSource: Factory<AppInitRemoteDataSource> {
        Factory(self) {
            AppInitRemoteDataSourceImpl(client: AppContainer.shared.client())
        }
        .singleton
    }
    
    public var appRepository: Factory<AppRepository> {
        Factory(self) {
            AppRepositoryImpl(dataSource: self.appRemoteDataSource())
        }
        .singleton
    }
    
    public var getAppInitUseCase: Factory<GetAppInitUseCase> {
        Factory(self) {
            GetAppInitUseCaseImpl(repository: self.appRepository())
        }
        .singleton
    }
}

// MARK: - Shop

extension AppContainer {
    public var shopDataSource: Factory<ShopDataSource> {
        Factory(self) {
            ShopRemoteDataSource(client: self.client())
        }
        .singleton
    }
    
    public var shopRepository: Factory<ShopRepository> {
        Factory(self) {
            ShopRepositoryImpl(dataSource: self.shopDataSource())
        }
        .singleton
    }
    
    public var addToCartUseCase: Factory<AddToCartUseCase>  {
        Factory(self) {
            AddToCartUseCaseImpl(repository: self.shopRepository())
        }
        .singleton
    }
    
    public var updateQuantityUseCase: Factory<UpdateQuantityUseCase> {
        Factory(self) {
            UpdateQuantityUseCaseImpl(repository: self.shopRepository())
        }
        .singleton
    }
    
    public var getCartUseCase: Factory<GetCartUseCase> {
        Factory(self) {
            GetCartUseCaseImpl(repository: self.shopRepository())
        }
        .singleton
    }
    
    public var getSecretUseCase: Factory<GetSecretUseCase> {
        Factory(self) {
            GetSecretUseCaseImpl(repository: self.shopRepository())
        }
        .singleton
    }
    
    public var confirmPaymentUseCase: Factory<ConfirmPaymentUseCase> {
        Factory(self) {
            ConfirmPaymentUseCaseImpl(repository: self.shopRepository())
        }
        .singleton
    }
    
    public var clearCartUseCase: Factory<ClearCartUseCase> {
        Factory(self) {
            ClearCartUseCaseImpl(repository: self.shopRepository())
        }
        .singleton
    }
    
    public var notesUseCase: Factory<NotesUseCase> {
        Factory(self) {
            NotesUseCaseImpl(repository: self.shopRepository())
        }
        .singleton
    }
    
    public var promoCodeUseCase: Factory<PromoCodeUseCase> {
        Factory(self) {
            PromoCodeUseCaseImpl(repository: self.shopRepository())
        }
        .singleton
    }
    
    public var payWithPointsUseCase: Factory<PayWithPointsUseCase> {
        Factory(self) {
            PayWithPointsUseCaseImpl(repository: self.shopRepository())
        }
        .singleton
    }
    
    public var setCartUserDetailsUseCase: Factory<SetCartUserDetailsUseCase> {
        Factory(self) {
            SetCartUserDetailsUseCaseImpl(repository: self.shopRepository())
        }
        .singleton
    }
}

// MARK: - Order
extension AppContainer {
    public var orderRemoteDataSource: Factory<OrderDataSource> {
        Factory(self) {
            OrderRemoteDataSource(client: AppContainer.shared.client())
        }
        .singleton
    }
    
    public var orderRepository: Factory<OrderRepository> {
        Factory(self) {
            OrderRepositoryImpl(dataSource: self.orderRemoteDataSource())
        }
        .singleton
    }
    
    public var getOrderItemDetailsUseCase: Factory<GetOrderItemDetailsUseCase> {
        Factory(self) {
            GetOrderItemUseCaseImpl(repository: self.orderRepository())
        }
        .singleton
    }
    
    public var postOrderItemDetailsUseCase: Factory<PostOrderItemDetailsUseCase> {
        Factory(self) {
            PostOrderItemUseCaseImpl(repository: self.orderRepository())
        }
        .singleton
    }
}

// MARK: - Printer Device
extension AppContainer {
    public var printerDeviceDataSource: Factory<PrinterDeviceDataSource> {
        Factory(self) {
            PrinterDeviceDataSourceImpl(service: self.userDefaultsService())
        }
        .singleton
    }
    
    public var printerDeviceRepository: Factory<PrinterDeviceRepository> {
        Factory(self) {
            PrinterDeviceRepositoryImpl(dataSource: self.printerDeviceDataSource())
        }
        .singleton
    }
    
    public var savePrinterDeviceUseCase: Factory<SavePrinterDeviceUseCase> {
        Factory(self) {
            SavePrinterDeviceUseCaseImpl(repository: self.printerDeviceRepository())
        }
    }
    
    public var getPrinterDeviceUseCase: Factory<GetPrinterDeviceUseCase> {
        Factory(self) {
            GetPrinterDeviceUseCaseImpl(repository: self.printerDeviceRepository())
        }
    }
    
    public var deletePrinterDeviceUseCase: Factory<DeletePrinterDeviceUseCase> {
        Factory(self) {
            DeletePrinterDeviceUseCaseImpl(repository: self.printerDeviceRepository())
        }
    }
}

// MARK: - Terminal Device
extension AppContainer {
    public var terminalDeviceDataSource: Factory<TerminalDeviceDataSource> {
        Factory(self) {
            TerminalDeviceDataSourceImpl(service: self.userDefaultsService())
        }
        .singleton
    }
    
    public var terminalDeviceRepository: Factory<TerminalDeviceRepository> {
        Factory(self) {
            TerminalDeviceRepositoryImpl(dataSource: self.terminalDeviceDataSource())
        }
        .singleton
    }
    
    public var saveTerminalDeviceUseCase: Factory<SaveTerminalDeviceUseCase> {
        Factory(self) {
            SaveTerminalDeviceUseCaseImpl(repository: self.terminalDeviceRepository())
        }
    }
    
    public var getTerminalDeviceUseCase: Factory<GetTerminalDeviceUseCase> {
        Factory(self) {
            GetTerminalDeviceUseCaseImpl(repository: self.terminalDeviceRepository())
        }
    }
    
    public var deleteTerminalDeviceUseCase: Factory<DeleteTerminalDeviceUseCase> {
        Factory(self) {
            DeleteTerminalDeviceUseCaseImpl(repository: self.terminalDeviceRepository())
        }
    }
}

// MARK: - Terminal Device Secret
extension AppContainer {
    public var deviceSecretDataSource: Factory<DeviceSecretDataSource> {
        Factory(self) {
            DeviceSecretDataSourceImpl(client: AppContainer.shared.client(), service: AppContainer.shared.userDefaultsService())
        }
    }
    
    public var deviceSecretRepository: Factory<DeviceSecretRepository> {
        Factory(self) {
            DeviceSecretRepositoryImpl(dataSource: self.deviceSecretDataSource())
        }
    }
    
    public var getRemoteDeviceSecretUseCase: Factory<GetRemoteDeviceSecretUseCase> {
        Factory(self) {
            GetRemoteDeviceSecretUseCaseImpl(repository: self.deviceSecretRepository())
        }
    }
    
    // Selected local
    public var getLocalDeviceSecretUseCase: Factory<GetLocalDeviceSecretUseCase> {
        Factory(self) {
            GetLocalDeviceSecretUseCaseImpl(repository: self.deviceSecretRepository())
        }
        .singleton
    }
    
    public var saveDeviceSecretUseCase: Factory<SaveDeviceSecretUseCase> {
        Factory(self) {
            SaveDeviceSecretUseCaseImpl(repository: self.deviceSecretRepository())
        }
        .singleton
    }
    
    public var deleteDeviceSecretUseCase: Factory<DeleteDeviceSecretUseCase> {
        Factory(self) {
            DeleteDeviceSecretUseCaseImpl(repository: self.deviceSecretRepository())
        }
        .singleton
    }
}
