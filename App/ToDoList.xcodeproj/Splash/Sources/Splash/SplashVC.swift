import UIKit

public final class SplashVC: UIViewController {
    public var contentView: SplashContentView
    public var viewModel: any SplashViewModel
    
    public init(contentView: SplashContentView, viewModel: any SplashViewModel) {
        self.contentView = contentView
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    override public func loadView() {
        view = contentView
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SplashVC: SplashDelegate {
    public func finishedFetchingData() {
    }
}
