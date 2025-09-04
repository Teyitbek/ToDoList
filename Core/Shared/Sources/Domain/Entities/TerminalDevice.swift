import Foundation

public struct TerminalDevice {
    public var name: String?
    public var serialNumber: String
    
    public init(name: String? = nil, serialNumber: String) {
        self.name = name
        self.serialNumber = serialNumber
    }
}
