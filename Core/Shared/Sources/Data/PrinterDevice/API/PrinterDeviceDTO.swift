import Domain
import Foundation

public struct PrinterDeviceDTO: Codable, DomainMappable {
    var name: String
    var ipAddress: String
    let modelName: String?
    let target: String?
    let macAddress: String?
    
    init(name: String, ipAddress: String, modelName: String?, target: String?, macAddress: String?) {
        self.name = name
        self.ipAddress = ipAddress
        self.modelName = modelName
        self.target = target
        self.macAddress = macAddress
    }
}

public extension PrinterDeviceDTO {
    func toDomain() -> PrinterDevice {
        PrinterDevice(name: name,
                      ipAddress: ipAddress,
                      modelName: modelName,
                      target: target,
                      macAddress: macAddress)
    }
}
