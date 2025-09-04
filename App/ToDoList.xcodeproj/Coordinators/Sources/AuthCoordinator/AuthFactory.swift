import Login
import Splash

public protocol AuthenticationFactory {
    func makeLoginVC() -> LoginVC
    func makeSplashModule() -> SplashVC
}

public final class AuthFactory: AuthenticationFactory {
    public init() {}
    
    public func makeLoginVC() -> LoginVC {
        let viewModel = LoginVM()
        let contentView = LoginCV()
        let vc = LoginVC(contentView: contentView, viewModel: viewModel)
        return vc
    }
    
    public func makeSplashModule() -> SplashVC {
        let viewModel = SplashVM()
        let contentView = SplashCV()
        let vc = SplashVC(contentView: contentView, viewModel: viewModel)
        return vc
    }
}
