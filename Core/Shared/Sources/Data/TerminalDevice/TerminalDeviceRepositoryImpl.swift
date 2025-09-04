import Domain

public struct TerminalDeviceRepositoryImpl: TerminalDeviceRepository {
    private let dataSource: TerminalDeviceDataSource
    
    public init(dataSource: TerminalDeviceDataSource) {
        self.dataSource = dataSource
    }
    
    public func getTerminalDevice() throws -> TerminalDevice? {
        try dataSource.getTerminalDevice()
    }
    
    public func save(terminalDevice: TerminalDevice) throws {
        try dataSource.save(terminalDevice: terminalDevice)
    }
    
    public func deleteTerminalDevice() throws {
        try dataSource.deleteTerminalDevice()
    }
}
