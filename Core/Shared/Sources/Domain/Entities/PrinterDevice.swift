import Foundation

public struct PrinterDevice {
    public let name: String
    public let ipAddress: String
    public let modelName: String?
    public let target: String?
    public let macAddress: String?
    
    public init(name: String, ipAddress: String, modelName: String?, target: String?, macAddress: String?) {
        self.name = name
        self.ipAddress = ipAddress
        self.modelName = modelName
        self.target = target
        self.macAddress = macAddress
    }
    
    public func toDict(isActive: Bool) -> [String: String] {
        [
            "name": name,
            "ipAddress": ipAddress,
            "modelName": modelName ?? "",
            "target": target ?? "",
            "macAddress": macAddress ?? "",
            "isActive": "\(isActive)"
        ]
    }
}
