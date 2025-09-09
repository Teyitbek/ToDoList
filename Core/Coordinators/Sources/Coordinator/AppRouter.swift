import UIKit

public final class AppRouter: NSObject, Router {
    private weak var rootController: UINavigationController?
    private var completions: [UIViewController: () -> Void]
    
    public init(rootController: UINavigationController) {
        self.rootController = rootController
        completions = [:]
    }
    
    public func toPresent() -> UIViewController? {
        return rootController
    }
    
    public func present(_ module: Presentable?) {
        present(module, animated: true)
    }
    
    public func present(_ module: Presentable?, animated: Bool) {
        guard let controller = module?.toPresent() else { return }
        if let lastVC = rootController?.viewControllers.last {
            lastVC.definesPresentationContext = true
            lastVC.present(controller, animated: animated)
        } else {
            rootController?.present(controller, animated: animated)
        }
    }
    
    public func present(_ module: Presentable?, onNC: UINavigationController) {
        guard let controller = module?.toPresent() else { return }
        onNC.present(controller, animated: true)
    }
        
    public func dismissModule() {
        dismissModule(animated: true, completion: nil)
    }
    
    public func dismissModule(animated: Bool, completion: (() -> Void)?) {
        if let lastVC = rootController?.viewControllers.last {
            lastVC.dismiss(animated: true)
        } else {
            rootController?.dismiss(animated: animated, completion: completion)
        }
    }
    
    public func push(_ module: Presentable?, hideBar: Bool = true) {
        push(module, animated: true)
    }
    
    public func push(_ module: Presentable?, hideBar: Bool = true, hideBottomBar: Bool) {
        push(module, hideBar: hideBar, animated: true, hideBottomBar: hideBottomBar, completion: nil)
    }
    
    public func push(_ module: Presentable?, hideBar: Bool = true, animated: Bool) {
        push(module, animated: animated, completion: nil)
    }
    
    public func push(_ module: Presentable?, hideBar: Bool = true, animated: Bool, completion: (() -> Void)?) {
        push(module, hideBar: hideBar, animated: animated, hideBottomBar: false, completion: completion)
    }
    
    public func push(_ module: Presentable?, hideBar: Bool, animated: Bool, hideBottomBar: Bool, completion: (() -> Void)?) {
        guard
            let controller = module?.toPresent(),
            (controller is UINavigationController == false)
        else { assertionFailure("Deprecated push UINavigationController."); return }
        
        if let completion = completion {
            completions[controller] = completion
        }
        controller.hidesBottomBarWhenPushed = hideBottomBar
        rootController?.pushViewController(controller, animated: animated)
    }
    
    public func popModule() {
        popModule(animated: true)
    }
    
    public func popModule(animated: Bool) {
        if let controller = rootController?.popViewController(animated: animated) {
            runCompletion(for: controller)
        }
    }
    
    public func setRootModule(_ module: Presentable?) {
        setRootModule(module, hideBar: false, hideNavigationBar: true)
    }
    
    public func setRootModule(_ module: Presentable?, hideBar: Bool, hideNavigationBar: Bool) {
        guard let controller = module?.toPresent() else { return }
        rootController?.setViewControllers([controller], animated: false)
    }
    
    public func setRootModule(_ module: Presentable?, hideBar: Bool, animated: Bool = false) {
        guard let controller = module?.toPresent() else { return }
        rootController?.setViewControllers([controller], animated: animated)
    }
    
    public func popToRootModule(animated: Bool) {
        if let controllers = rootController?.popToRootViewController(animated: animated) {
            controllers.forEach { controller in
                runCompletion(for: controller)
            }
        }
    }
    
    private func runCompletion(for controller: UIViewController) {
        guard let completion = completions[controller] else { return }
        completion()
        completions.removeValue(forKey: controller)
    }
}
