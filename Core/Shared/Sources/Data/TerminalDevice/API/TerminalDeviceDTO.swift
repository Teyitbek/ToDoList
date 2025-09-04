import Domain
import Foundation

public struct TerminalDeviceDTO: Codable, DomainMappable {
    var name: String?
    var serialNumber: String
    
    init(name: String? = nil, serialNumber: String) {
        self.name = name
        self.serialNumber = serialNumber
    }
}

public extension TerminalDeviceDTO {
    func toDomain() -> TerminalDevice {
        TerminalDevice(name: name, serialNumber: serialNumber)
    }
}
