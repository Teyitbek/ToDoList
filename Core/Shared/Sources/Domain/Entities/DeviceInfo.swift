import UIKit

public struct DeviceInfo {
    public static var userDefinedName: String {
        UIDevice.current.name
    }

    static var modelIdentifier: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        return machineMirror.children.reduce("") { acc, element in
            guard let value = element.value as? Int8, value != 0 else { return acc }
            return acc + String(UnicodeScalar(UInt8(value)))
        }
    }

    public static var modelName: String {
        let identifier = modelIdentifier
        switch identifier {
        case "iPad8,9": return "iPad Pro (11-inch) (2nd generation)"
        case "iPad13,4", "iPad13,5": return "iPad Pro (11-inch) (3rd generation)"
        case "iPad14,3", "iPad14,4": return "iPad Pro (11-inch) (4th generation)"
        // Add more as needed...
        default: return identifier
        }
    }
}
