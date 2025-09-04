import Domain
import Foundation

public typealias UseCases = (saveLocationUseCase: SaveLocationUseCase,
                             retrieveLocationUseCase: RetrieveLocationUseCase,
                             deleteLocationUseCase: DeleteLocationUseCase,
                             saveAccessTokenUseCase: SaveAccessTokenUseCase,
                             saveUserUseCase: SaveUserUseCase,
                             retrieveUserUseCase: RetrieveUserUseCase,
                             retrieveAccessTokenUseCase: RetrieveAccessTokenUseCase,
                             deleteAccessTokenUseCase: DeleteAccessTokenUseCase,
                             deleteUserUseCase: DeleteUserUseCase,
                             saveDeviceUIDUseCase: SaveDeviceUIDUseCase,
                             retrieveDeviceUIDUseCase: RetrieveDeviceUIDUseCase,
                             deleteDeviceUIDUseCase: DeleteDeviceUIDUseCase,
                             savePrinterDeviceUseCase: SavePrinterDeviceUseCase,
                             getPrinterDeviceUseCase: GetPrinterDeviceUseCase,
                             deletePrinterDeviceUseCase: DeletePrinterDeviceUseCase,
                             saveTerminalDeviceUseCase: SaveTerminalDeviceUseCase,
                             getTerminalDeviceUseCase: GetTerminalDeviceUseCase,
                             deleteTerminalDeviceUseCase: DeleteTerminalDeviceUseCase)

public final class SessionService: SessionManaging {
    private let useCases: UseCases

    public var accessTokenIsAvailable: Bool {
        if let token = retrieveAccessToken() {
            return !token.accessToken.isEmpty
        } else {
            return false
        }
    }
    
    public var locationIsAvailable: Bool {
        if let location = retrieveLocation() {
            return !location.name.isEmpty
        } else {
            return false
        }
    }
    
    public var user: UserRepresentable? {
        do {
            return try useCases.retrieveUserUseCase.execute()
        } catch {
            return nil
        }
    }
    
    public var accessToken: String? {
        if let token = retrieveAccessToken() {
            return token.accessToken
        } else {
            return nil
        }
    }
    
    public var location: Locationable? {
        return retrieveLocation()
    }
    
    public init(useCases: UseCases) {
        self.useCases = useCases
    }
    
    public func retrieveAccessToken() -> Tokenizable? {
        do {
            return try useCases.retrieveAccessTokenUseCase.execute()
        } catch {
            return nil
        }
    }
    
    public func save(user: UserRepresentable) throws {
        try useCases.saveUserUseCase.execute(with: user)
    }
    
    public func save(deviceUID: String) throws {
        try useCases.saveDeviceUIDUseCase.execute(with: deviceUID)
    }
    
    public func retrieveDeviceUID() -> String? {
        do {
            return try useCases.retrieveDeviceUIDUseCase.execute()
        } catch {
            return nil
        }
    }
    
    public func deleteAccessToken() throws {
        try useCases.deleteAccessTokenUseCase.execute()
    }
    
    public func save(accessToken: any Tokenizable) throws {
        try useCases.saveAccessTokenUseCase.execute(with: accessToken)
    }
    
    public func deleteLocation() throws {
        try useCases.deleteLocationUseCase.execute()
    }
    
    public func save(location: any Locationable) throws {
        try useCases.saveLocationUseCase.execute(with: location)
    }
    
    public func retrieveLocation() -> Locationable? {
        do {
            return try useCases.retrieveLocationUseCase.execute()
        } catch {
            return nil
        }
    }
    
    public func retrievePrinterDevice() -> PrinterDevice? {
        do {
            return try useCases.getPrinterDeviceUseCase.execute()
        } catch {
            return nil
        }
    }
    
    public func save(printerDevice: PrinterDevice) throws {
        try useCases.savePrinterDeviceUseCase.execute(printerDevice: printerDevice)
    }
    
    public func deletePrinterDevice() throws {
        try useCases.deletePrinterDeviceUseCase.execute()
    }
    
    public func retrieveTerminalDevice() -> TerminalDevice? {
        do {
            return try useCases.getTerminalDeviceUseCase.execute()
        } catch {
            return nil
        }
    }
    
    public func save(terminalDevice: TerminalDevice) throws {
        try useCases.saveTerminalDeviceUseCase.execute(terminalDevice: terminalDevice)
    }
    
    public func deleteTerminalDevice() throws {
        try useCases.deleteTerminalDeviceUseCase.execute()
    }
    
    public func resetAll() throws {
        try useCases.deleteAccessTokenUseCase.execute()
        try useCases.deleteUserUseCase.execute()
        try useCases.deleteDeviceUIDUseCase.execute()
        try useCases.deleteLocationUseCase.execute()
    }
    
    public func logout() throws {
        try useCases.deleteAccessTokenUseCase.execute()
        try useCases.deleteUserUseCase.execute()
    }
    
    public func deleteDeviceUID() throws {
        try useCases.deleteDeviceUIDUseCase.execute()
    }
    
    public func deleteUser() throws {
        try useCases.deleteUserUseCase.execute()
    }
}
