import UIKit

public extension UIButton {
    func setTitleWithoutAnimation(_ title: String?, for controlState: UIControl.State) {
        UIView.performWithoutAnimation {
            self.setTitle(title, for: controlState)
            self.layoutIfNeeded()
        }
    }
}
