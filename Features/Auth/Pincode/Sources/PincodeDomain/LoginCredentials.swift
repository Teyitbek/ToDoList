import Domain

public struct LoginCredentials: Pincodeable {
    public var pin: String
    
    public init(pin: String) {
        self.pin = pin
    }
}
