import UIKit

open class NavigationController: UINavigationController {
    open override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscapeRight
    }
    
    open override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return .landscapeRight
    }
    
    open override var shouldAutorotate: Bool {
        return true
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.isHidden = true
    }
}
