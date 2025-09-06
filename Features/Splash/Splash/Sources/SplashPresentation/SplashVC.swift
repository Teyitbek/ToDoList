import ActivityIndicator
import UIKit
import Base

public final class SplashVC: ViewController<SplashCV, SplashVM> {
    override public func viewDidLoad() {
        super.viewDidLoad()
        bindVM()
        viewModel.onFinish?(true)
    }
    
    public override func bindVM() {
        super.bindVM()
    }
    
    public override func bindCV() {
        super.bindCV()
    }
}
