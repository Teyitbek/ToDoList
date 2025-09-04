import Combine
import UIKit
import Foundation
import Data
import Domain
import StartDomain
import Base

public protocol StartViewModel {
    var onStartAction: CompletionClosure? { get set }
    var getLanguagesTask: Task<Void,Never>? { get set }
    var languagesSubject: CurrentValueSubject<[LanguageRepresentable], Never> { get }
    var selectedLanguage: LanguageRepresentable? { get set }
    
    @MainActor
    func getData()
    
    @MainActor
    func saveSelectedLanguage()
}

public typealias UseCases = (getLanguages: GetRemoteLanguagesUseCase,
                             saveLanguages: SaveLanguagesUseCase,
                             saveSelectedLanguage: SaveSelectedLanguageUseCase,
                             getBanners: GetBannersUseCase,
                             getLabels: GetLabelsUseCase,
                             saveLabels: SaveLabelsUseCase)

public final class StartVM: ViewModel, StartViewModel {
    public var useCases: UseCases
    
    public var onStartAction: CompletionClosure?
    
    public var getLanguagesTask: Task<Void, Never>?
    public var languagesSubject = CurrentValueSubject<[LanguageRepresentable], Never>([])
    public var bannersSubject = CurrentValueSubject<[BannerRepresentable], Never>([])
    public var saveSelectedLanguageTask: Task<Void,Never>?
    public var getLabelsTask: Task<Void,Never>?
    public var socketService: SocketServicing
    public var printerManager: PrinterManager
    public var selectedLanguage: LanguageRepresentable?
    public var sessionService: SessionManaging
    
    public init(labelsSubjct: CurrentValueSubject<[String:String], Never>,
                socketService: SocketServicing,
                printerManager: PrinterManager,
                sessionService: SessionManaging,
                useCases: UseCases) {
        self.useCases = useCases
        self.socketService = socketService
        self.printerManager = printerManager
        self.sessionService = sessionService
        super.init(labelsSubject: labelsSubjct)
    }
    
    @MainActor
    public func getData() {
        activityIndicatorIsHiddenSubject.send(false)
        
        getLanguagesTask = Task {
            do {
                let languages = try await useCases.getLanguages.execute()
                let banners = try await useCases.getBanners.execute()
                try useCases.saveLanguages.execute(languages: languages)
                
                if let first = languages.first {
                    try? useCases.saveSelectedLanguage.execute(language: first)
                    selectedLanguage = first
                    getLabels(onStart: false)
                }
                bannersSubject.send(banners)
                languagesSubject.send(languages)
                activityIndicatorIsHiddenSubject.send(true)
            } catch {
                errorSubject.send(error)
                activityIndicatorIsHiddenSubject.send(true)
            }
        }
    }
    
    @MainActor
    public func saveSelectedLanguage() {
        guard let selectedLanguage else { return }
        activityIndicatorIsHiddenSubject.send(false)
        
        saveSelectedLanguageTask = Task {
            do {
                try useCases.saveSelectedLanguage.execute(language: selectedLanguage)
                let labels = try await useCases.getLabels.execute(with: selectedLanguage.id)
                try useCases.saveLabels.execute(labels)
                labelsSubject.send(labels)
                getLabels(onStart: true)
            } catch {
                errorSubject.send(error)
                activityIndicatorIsHiddenSubject.send(true)
            }
        }
    }
    
    @MainActor
    func getLabels(onStart: Bool) {
        guard let selectedLanguage else { return }
        
        getLabelsTask = Task {
            do {
                let labels = try await useCases.getLabels.execute(with: selectedLanguage.id)
                try useCases.saveLabels.execute(labels)
                labelsSubject.send(labels)
                activityIndicatorIsHiddenSubject.send(true)
                onStart ? onStartAction?() : ()
            } catch {
                errorSubject.send(error)
                activityIndicatorIsHiddenSubject.send(true)
            }
        }
    }
}
