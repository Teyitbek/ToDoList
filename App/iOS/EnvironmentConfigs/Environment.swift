import Foundation

enum PlistKey: String, CaseIterable {
    case baseAPIURL = "BASE_URL"
    case appstoreLink = "APPSTORE_LINK"
    case sentryDSN = "SENTRY_DSN"
    case stripeRedirectURLScheme = "STRIPE_REDIRECT_URL_SCHEME"
    case socketURL = "SOCKET_BASE_URL"
}

enum Environment {
    enum EnvironmentType: String {
        case development
        case production
        case staging
    }
    
    static var current: EnvironmentType {
        #if DEVELOPMENT
        return .development
        #elseif PRODUCTION
        return .production
        #elseif STAGING
        return .staging
        #endif
    }
    
    static func value(for key: PlistKey) -> String {
        guard let url = Bundle.main.path(forResource: "EnvironmentConfigs", ofType: "plist"),
              let configs = NSDictionary(contentsOfFile: url),
              let configValue = configs[key.rawValue] as? String else {
            fatalError("Couldn't find such string for '\(key.rawValue)' key in plist configuration file")
        }
        return configValue
    }
}
