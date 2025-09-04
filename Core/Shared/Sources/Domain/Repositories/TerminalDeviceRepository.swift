import Foundation

public protocol TerminalDeviceRepository {
    func getTerminalDevice() throws -> TerminalDevice?
    func save(terminalDevice: TerminalDevice) throws
    func deleteTerminalDevice() throws
}
