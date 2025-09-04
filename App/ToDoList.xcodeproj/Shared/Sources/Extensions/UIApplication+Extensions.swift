import UIKit

public extension UIApplication {
    static var getKeyWindow: UIWindow? {
        return (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first
    }
}
