import Foundation

public struct LocalizationManager {
    private let strings: [String: String]
    
    public init(strings: [String : String]) {
        self.strings = strings
    }
    
    public func localize(_ localizationKey: String) -> String {
        if let string = strings[localizationKey] {
            return string
        } else {
            return localizationKey
        }
    }
    
    public func getStrings() async throws {
    }
}
