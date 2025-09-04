import Foundation

extension Float {
    public func formatted(digits: Int) -> String {
        String(format: "$ %.\(digits)f", self)
    }
}
