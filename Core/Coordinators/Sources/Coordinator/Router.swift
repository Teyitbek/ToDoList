import UIKit

public protocol Router: Presentable {
    func present(_ module: Presentable?)
    func present(_ module: Presentable?, animated: Bool)
    func present(_ module: Presentable?, onNC: UINavigationController)
    
    func push(_ module: Presentable?, hideBar: Bool)
    func push(_ module: Presentable?, hideBar: Bool, hideBottomBar: Bool)
    func push(_ module: Presentable?, hideBar: Bool, animated: Bool)
    func push(_ module: Presentable?, hideBar: Bool, animated: Bool, completion: (() -> Void)?)
    func push(_ module: Presentable?, hideBar: Bool, animated: Bool, hideBottomBar: Bool, completion: (() -> Void)?)
    
    func popModule()
    func popModule(animated: Bool)
    
    func dismissModule()
    func dismissModule(animated: Bool, completion: (() -> Void)?)
    
    func setRootModule(_ module: Presentable?)
    func setRootModule(_ module: Presentable?, hideBar: Bool, hideNavigationBar: Bool)
    func setRootModule(_ module: Presentable?, hideBar: Bool, animated: Bool)
    
    func popToRootModule(animated: Bool)
}
