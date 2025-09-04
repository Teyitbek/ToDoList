import UIKit

open class SplitController: UISplitViewController {
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
        delegate = self
    }
}

extension SplitController: UISplitViewControllerDelegate {
    open func splitViewController(_ svc: UISplitViewController, topColumnForCollapsingToProposedTopColumn proposedTopColumn: UISplitViewController.Column) -> UISplitViewController.Column {
        return .primary
    }
}
