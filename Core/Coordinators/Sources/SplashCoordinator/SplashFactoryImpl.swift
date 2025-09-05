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
        let viewModel = SplashVM(
                                 appType: container.appType(),
                                 appVersion: container.appVersion(),
                                 useCases: (container.deviceUIDUseCase(),
                                            container.appInitUseCase(),
                                            container.getAccountIndexUseCase()),
                                 sessionService: container.sessionService(),
                                 appInitSubject: container.appInit())
        let contentView = SplashCV()
        viewModel.onSetDeviceUID = container.setDeviceUID
        let vc = SplashVC(contentView: contentView, viewModel: viewModel)
        return vc
    }
}
