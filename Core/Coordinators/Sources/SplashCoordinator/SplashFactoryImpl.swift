import Domain
import SplashDI
import SplashPresentation

public protocol SplashFactory {
    func makeSplashModule() -> SplashVC
}

public final class SplashFactoryImpl: SplashFactory {
    public init() {}
    
    public func makeSplashModule() -> SplashVC {
        let container = SplashContainer()
        let viewModel = SplashVM(appType: container.appType(),
                                 appVersion: container.appVersion(),
                                 useCases: (),
                                 sessionService: container.sessionService(),
                                 appInitSubject: container.appInit())
        let contentView = SplashCV()
        let vc = SplashVC(contentView: contentView, viewModel: viewModel)
        return vc
    }
}
