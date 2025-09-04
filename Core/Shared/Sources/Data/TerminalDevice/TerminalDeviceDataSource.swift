import Domain

public protocol TerminalDeviceDataSource {
    func getTerminalDevice() throws -> TerminalDevice?
    func save(terminalDevice: TerminalDevice) throws
    func deleteTerminalDevice() throws
}
