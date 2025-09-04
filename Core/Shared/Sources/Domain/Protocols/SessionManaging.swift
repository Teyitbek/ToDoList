import Foundation

public protocol SessionManaging {
    var accessTokenIsAvailable: Bool { get }
    var locationIsAvailable: Bool { get }
    var user: UserRepresentable? { get }
    var accessToken: String? { get }
    var location: Locationable? { get }
    func save(user: UserRepresentable) throws
    func save(accessToken: Tokenizable) throws
    func save(deviceUID: String) throws
    func retrieveDeviceUID() -> String?
    func deleteDeviceUID() throws
    func retrieveAccessToken() -> Tokenizable?
    func save(location: Locationable) throws
    func retrieveLocation() -> Locationable?
    func retrievePrinterDevice() -> PrinterDevice?
    func save(printerDevice: PrinterDevice) throws
    func deletePrinterDevice() throws
    func retrieveTerminalDevice() -> TerminalDevice?
    func save(terminalDevice: TerminalDevice) throws
    func deleteTerminalDevice() throws
    func deleteLocation() throws
    func deleteUser() throws
    func deleteAccessToken() throws
    func resetAll() throws
    func logout() throws
}
