import Foundation
import Sentry
import Session

public final class NetworkLogger: NetworkLoggable {
    public var session: SessionProtocol
    var environment: String
    
    init(session: SessionProtocol, environment: String) {
        self.session = session
        self.environment = environment
    }
    
    func start(with dsn: String) {
        SentrySDK.start { [unowned self] options in
            options.dsn = dsn
            options.environment = self.environment
        }
    }
    
    public func log(with request: URLRequest?, response: HTTPURLResponse?, data: Data?, level: SentryLevel = .info, state: NetworkRequestState = .success) {
        let message = Message(state: state,
                                            request: request,
                                            response: response,
                                            responseData: data,
                                            level: level)
        
        capture(message)
    }
    
    func capture(_ message: Message) {
        SentrySDK.capture(message: message.build()) { [weak self] scope in
            guard let self = self else { return }
            scope.setLevel(message.level)
            scope.setTag(value: self.session.userDetails.name, key: "name")
            scope.setTag(value: self.session.userDetails.id, key: "id")
            scope.setFingerprint([message.route()])
        }
    }
    
    func captureObjectMappingError(with error: DecodingError, model: Decodable.Type) {
        SentrySDK.capture(message:
        """
        \n OBJECT MAPPING FAILED:
        \n For model: \(model.self)
        \n Error message: \(error.localizedDescription)
        \n Reason: \(error)
        """)
    }
}
