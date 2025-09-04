import UIKit

public final class LoginVC: UIViewController {
    public var contentView: LoginContentView
    public var viewModel: any LoginViewModel
    
    override public func loadView() {
        view = contentView
    }
    
    public init(contentView: LoginContentView, viewModel: any LoginViewModel) {
        self.contentView = contentView
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    public func viewDidLoad() {
        super.viewDidLoad()
    }
    
    public func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
