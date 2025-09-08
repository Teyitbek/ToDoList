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
    
    public var sessionService: Factory<SessionManaging> {
        Factory(self) {
            SessionService(useCases: ()
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
            ""
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
    
    public var userDefaultsService: Factory<PersistentStorage> {
        Factory(self) {
            UserDefaultsService()
        }
        .singleton
    }
    
    public var client: Factory<HTTPClient> {
        Factory(self) {
            let client = HTTPClient(baseURL: URL(string: self.baseAPIURL()))
            client.validators.append(ResponseLogValidator())
            client.headers.set("appType", self.appType())
            client.headers.set("appVersion", self.appVersion())
            client.headers.set("deviceUid", self.deviceUid())
            client.headers.set("deviceName", self.deviceName())
            client.headers.set("deviceModel", self.deviceModel())
            return client
        }
        .singleton
    }
    
    // MARK: - Core Data
    public var coreDataManager: Factory<CoreDataManager> {
        Factory(self) {
            CoreDataManager.shared
        }
        .singleton
    }
}
