import Foundation

enum BuildConfigPlistKey: String, CaseIterable {
    case appVersion = "CFBundleShortVersionString"
    case appBuild = "CFBundleVersion"
}

enum BuildConfigs {
    static func value(for key: BuildConfigPlistKey) -> String {
        guard let url = Bundle.main.path(forResource: "Info", ofType: "plist"),
              let configs = NSDictionary(contentsOfFile: url),
              let configValue = configs[key.rawValue] as? String else {
            fatalError("Couldn't find such string for '\(key.rawValue)' key in plist configuration file")
        }
        return configValue
    }
}
