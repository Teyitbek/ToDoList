public protocol Instructor {
    associatedtype UserSession
    var session: UserSession { get }
    init(session: UserSession)
    func startOption() -> LaunchOption
}
