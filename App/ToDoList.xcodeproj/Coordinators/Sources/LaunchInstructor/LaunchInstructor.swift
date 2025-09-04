import Session

public final class LaunchInstructor: Instructor {
    public var session: SessionProtocol
    
    public init(session: SessionProtocol) {
        self.session = session
    }
    
    public func startOption() -> LaunchOption {
        guard session.isAuthorized else { return .auth }
        guard !session.getToken().isEmpty else { return .auth }
        return .main
    }
}
