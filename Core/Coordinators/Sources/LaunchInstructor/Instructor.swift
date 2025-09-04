public protocol Instructor {
    associatedtype UserSession
    var sessionService: UserSession { get }
    var isSplashShown: Bool { get set }
    init(sessionService: UserSession, isSplashShown: Bool)
    func startOption() -> LaunchOption
}
