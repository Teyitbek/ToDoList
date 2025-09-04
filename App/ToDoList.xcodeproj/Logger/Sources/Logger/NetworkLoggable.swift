import Foundation
import Sentry
import Session

public protocol NetworkLoggable {
    var session: SessionProtocol { get set }
    func log(with request: URLRequest?, response: HTTPURLResponse?, data: Data?, level: SentryLevel, state: NetworkRequestState)
}
