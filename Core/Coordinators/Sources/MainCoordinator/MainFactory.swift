import StartDI
import StartPresentation
import Domain
import Combine

public protocol MainFactory {
    func makeStartModule() -> StartVC
}

public final class MainModuleFactory: MainFactory {
    public init() {}
    
    public func makeStartModule() -> StartVC {
        let container = StartContainer()
        let contentView = StartCV()
//        let viewModel = StartVM(labelsSubjct: container.labelsSubject(),
//                                socketService: container.socketService(),
//                                printerManager: container.printerManager(),
//                                sessionService: container.sessionService(),
//                                useCases: (container.getRemoteLanguagesUseCase(),
//                                           container.saveLanguagesUseCase(),
//                                           container.saveSelectedLanguageUseCase(),
//                                           container.getBannersUseCase(),
//                                           container.getLabelsUseCase(),
//                                           container.saveLabelsUseCase()))
        
        let viewModel = StartVM(labelsSubjct: container.labelsSubject(),
                                sessionService: container.sessionService(),
                                useCases: ())
        let viewController = StartVC(contentView: contentView, viewModel: viewModel)
        return viewController
    }
}
