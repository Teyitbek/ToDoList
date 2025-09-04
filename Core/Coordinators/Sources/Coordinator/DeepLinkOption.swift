import Foundation
import UIKit

enum DeepLinkURLConstants {
    static let Settings = "settings"
    static let Pincode = "pincode"
    static let SignUp = "signUp"
}

public enum DeepLinkOption {
    case none
    
    static func build(with userActivity: NSUserActivity) -> DeepLinkOption? {
        if userActivity.activityType == NSUserActivityTypeBrowsingWeb,
           let url = userActivity.webpageURL,
           let components = URLComponents(url: url, resolvingAgainstBaseURL: true) {
            // TODO: extract string and match with DeepLinkURLConstants
            print("URL components: \(components)")
        }
        return nil
    }
    
    static func build(with userInfo: [AnyHashable: Any]) -> DeepLinkOption? {
        guard let notification = PushNotification.map(userInfo) else { return nil }
        switch notification.type {
        case .none:
            return nil
        }
    }
    
    static func option(from launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> DeepLinkOption? {
        guard let notification = launchOptions?[.remoteNotification] as? [AnyHashable: Any] else { return nil }
        return build(with: notification)
    }
}
