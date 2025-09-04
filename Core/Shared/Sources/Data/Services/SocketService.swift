//import Combine
//import Domain
//import Extensions
//import Foundation
////import SocketIO
//
//public enum SocketStatus {
//    case connect
//    case disconnect
//    case ping
//    case pong
//    case reconnect
//    case reconnectAttempt
//    case statusChange
//    case websocketUpgrade
//}
//
//public protocol SocketServicing {
//    var socketStatusSubject: PassthroughSubject<SocketStatus,  Never> { get }
//    var ordersSubject: CurrentValueSubject<[Order], Never> { get }
//    var userSubject: PassthroughSubject<UserRepresentable, Never> { get }
//    var errorSubject: PassthroughSubject<Error, Never> { get }
//    
//    func connect()
//    func disconnect()
//    func printerUpdated(with details: [String: String])
//}
//
//public final class SocketService: NSObject, SocketServicing {
////    private let client: SocketIOClient
//    private let session: SessionManaging
//    private let socketURL: String
////    private let socketManager: SocketManager
//    private let appType: String
//    private let appVersion: String
//    private let deviceUID: String
//    public let socketStatusSubject = PassthroughSubject<SocketStatus, Never>()
//    public let ordersSubject = CurrentValueSubject<[Order], Never>(.init())
//    public let userSubject = PassthroughSubject<UserRepresentable, Never>()
//    public let errorSubject = PassthroughSubject<any Error, Never>()
//    
//    public init(session: SessionManaging, socketURL: String, appType: String, appVersion: String, deviceUID: String) {
//        self.session = session
//        self.socketURL = socketURL
////        self.socketManager = SocketManager(socketURL: URL(string: socketURL)!, config: [.log(true), .compress, .reconnects(true), .reconnectWait(1), .reconnectWaitMax(5)])
////        self.client = socketManager.defaultSocket
//        self.appType = appType
//        self.appVersion = appVersion
//        self.deviceUID = deviceUID
//        super.init()
//        startListening()
//    }
//    
////    public func connect() {
////        guard let accessToken = session.accessToken,
////        let location = session.retrieveLocation(),
////        let deviceUID = session.retrieveDeviceUID() else { return }
////        socketManager.config = SocketIOClientConfiguration(arrayLiteral: .extraHeaders(["authorization": accessToken, "appType": appType, "appVersion": appVersion, "deviceUid": deviceUID, "locationId": "\(location.id)"]))
////        client.connect()
////    }
//    
//    public func disconnect() {
//        socketManager.disconnect()
//    }
//    
//    public func printerUpdated(with details: [String : String]) {
//        client.emit("printer-updated", details)
//    }
//}
//
//extension SocketService {
//    func startListening() {
//        client.on(clientEvent: .disconnect) { [weak self] _, _ in
//            guard let self else { return }
//            self.socketStatusSubject.send(.disconnect)
//            guard session.accessTokenIsAvailable else { return }
//            self.connect()
//        }
//        
//        client.on(clientEvent: .connect) { [weak self] _, _ in
//            guard let self else { return }
//            self.socketStatusSubject.send(.connect)
//        }
//        
//        client.on(clientEvent: .ping) { [weak self] _, _ in
//            guard let self else { return }
//            self.socketStatusSubject.send(.ping)
//        }
//        
//        client.on(clientEvent: .pong) { [weak self] _, _ in
//            guard let self else { return }
//            self.socketStatusSubject.send(.pong)
//        }
//        
//        client.on(clientEvent: .reconnect) { [weak self] _, _ in
//            guard let self else { return }
//            self.socketStatusSubject.send(.reconnect)
//        }
//        
//        client.on(clientEvent: .reconnectAttempt) { [weak self] _, _ in
//            guard let self else { return }
//            self.socketStatusSubject.send(.reconnectAttempt)
//        }
//        
//        client.on(clientEvent: .statusChange) { [weak self] _, _ in
//            guard let self else { return }
//            self.socketStatusSubject.send(.statusChange)
//        }
//        
//        client.on(clientEvent: .websocketUpgrade) { [weak self] _, _ in
//            guard let self else { return }
//            self.socketStatusSubject.send(.websocketUpgrade)
//        }
//    }
//    
//    private func markSelectedIfNeeded(orders: [Order]) -> [Order] {
//        guard let selectedOrder = ordersSubject.value.first(where: { $0.selected }) else { return  orders }
//        orders.first { $0.id == selectedOrder.id }?.selected = true
//        return orders
//    }
//}
