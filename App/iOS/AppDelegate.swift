import AppContainer
import AppLauncher
import Base
import Combine
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: Window?
    var launcher: AppLauncher?
    var cancellables = Set<AnyCancellable>()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        window = Window()
        window?.makeKeyAndVisible()
        
        AppContainer.shared.baseAPIURL.register { Environment.value(for: .baseAPIURL) }
        AppContainer.shared.appVersion.register { BuildConfigs.value(for: .appVersion) }
        AppContainer.shared.appBuild.register { BuildConfigs.value(for: .appBuild) }
        
        launcher = AppLauncher(with: window!, container: AppContainer.shared)
        addObservers()
        launcher?.launch()
        return true
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
    }
    
    func addObservers() {
    }
}
