import Foundation

public extension Character {
    func containsSpecialCharacters() -> Bool {
        do {
            let regex = try NSRegularExpression(pattern: "[^a-z0-9 ]", options: .caseInsensitive)
            if regex.firstMatch(in: String(self), options: [], range: NSRange(location: 0, length: 1)) != nil {
                return true
            } else {
                return false
            }
        } catch {
            return true
        }
    }
}
