import Domain

public final class LaunchInstructor: Instructor {
    public var sessionService: SessionManaging
    public var isSplashShown: Bool
    
    public init(sessionService: SessionManaging, isSplashShown: Bool) {
        self.sessionService = sessionService
        self.isSplashShown = isSplashShown
    }
    
    public func startOption() -> LaunchOption {
        guard isSplashShown else {
            return sessionService.retrieveLocation() == nil ? .location : .splash
        }
        if sessionService.locationIsAvailable {
            return sessionService.accessTokenIsAvailable ? .main : .auth
        } else {
            return .location
        }
    }
}
