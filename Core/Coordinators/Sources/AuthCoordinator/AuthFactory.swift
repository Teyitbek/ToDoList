import Domain
import PincodeDI
import PincodePresentation

public protocol AuthenticationFactory {
    func makeLoginVC() -> PincodeVC
}

public final class AuthFactory: AuthenticationFactory {
    public init() {}
    
    public func makeLoginVC() -> PincodeVC {
        let container = PincodeContainer()
        let viewModel = PincodeVM(labelsSubjct: container.labelsSubject(),
                                  sessionService: container.sessionService(),
                                  loginUseCase: container.loginUseCase())
        viewModel.onSetAccessToken = container.setAccessToken
        let contentView = PincodeCV()
        let vc = PincodeVC(contentView: contentView, viewModel: viewModel)
        return vc
    }
}
