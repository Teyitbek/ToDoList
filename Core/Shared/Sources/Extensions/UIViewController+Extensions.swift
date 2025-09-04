import UIKit

///
/// UIViewController helpers to add and remove child view controllers.
///
public extension UIViewController {
    /// Predefined Layouts for an embedded controller
    enum BindLayoutOptions {
        /// Hidden. View of embedded controller is invisible. It can propagate
        /// other view into the partent controller.
        case zero
        /// Fill size of the parent controller.
        case fill
        /// Custom callback. Custom layout and custom setup.
        public typealias Callback = (_ childView: UIView) -> Void
        case custom(Callback)
    }

    /// Add child view controller with specified layout presets.
    /// - Parameters:
    ///   - child: controller to be added as a child controller
    ///   - layout: predefined layout
    func addController(embedded: UIViewController, layout: BindLayoutOptions = .fill) {
        addChild(embedded)
        embedded.willMove(toParent: self)
        setupView(child: embedded.view, layout: layout)
        embedded.didMove(toParent: self)
    }

    /// Remove child view controller from the parent controller.
    /// - Parameters:
    ///   - child: a controller to be added as a child controller
    func removeController(embedded: UIViewController) {
        embedded.willMove(toParent: nil)
        embedded.view.removeFromSuperview()
        embedded.removeFromParent()
    }
    
    /// Layout the child view in the superview
    /// - Parameters:
    ///   - child: view to be added as a child controller
    ///   - layout: predefined layout
    private func setupView(child: UIView, layout: BindLayoutOptions) {
        view.addSubview(child)
        
        switch layout {
        case .zero:
            child.frame = CGRect.zero
        case .fill:
            break
        case .custom(let callback):
            callback(child)
        }
    }
}
