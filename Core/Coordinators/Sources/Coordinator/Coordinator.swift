import Combine

public protocol Coordinator: AnyObject {
    var optionSubject: CurrentValueSubject<DeepLinkOption, Never> { get }
    func start()
}
