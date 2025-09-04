import ActivityIndicator
import Combine
import KeyboardManager
import MessageView
import UIKit

open class ViewController<CV: ContentViewRepresentable, VM: ViewModel>: UIViewController {
    public let contentView: CV
    public let viewModel: VM
    public var cancellables = Set<AnyCancellable>()
    public let feedbackgGenerator = UIImpactFeedbackGenerator(style: .light)
    public let hapticMediumFeedbackGenerator = UIImpactFeedbackGenerator(style: .medium)
    public let notificationFeedbackGenerator = UINotificationFeedbackGenerator()
    
    open override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscapeRight
    }
    
    open override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return .landscapeRight
    }
    
    open override var shouldAutorotate: Bool {
        return true
    }
    
    public init(contentView: CV, viewModel: VM) {
        self.contentView = contentView
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    public override func loadView() {
        view = contentView
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        bindCV()
        bindVM()
    }
    
    deinit {
        cancellables.removeAll()
        contentView.removeKeyboardVisibilityController()
        print("===> \(type(of: self)) is deinited")
    }
    
    open func retry() {}
    
    open func bindCV() {
        feedbackgGenerator.prepare()
        hapticMediumFeedbackGenerator.prepare()
        notificationFeedbackGenerator.prepare()
        contentView.addInputVisibilityController()
    }
    
    open func bindVM() {
        viewModel.labelsSubject
            .receive(on: DispatchQueue.main)
            .sink { [weak self] labels in
                self?.localize(with: labels)
            }
            .store(in: &cancellables)
        
        viewModel.activityIndicatorIsHiddenSubject
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isHidden in
                guard let self else { return }
                isHidden ? dismissActivity(): presentActivity()
            }
            .store(in: &cancellables)
        
        viewModel.errorSubject
            .receive(on: DispatchQueue.main)
            .sink { [weak self] error in
                guard let self else { return }
                showMessage(type: .error, message: error.localizedDescription)
            }
            .store(in: &cancellables)
        
        viewModel.messageSubject
            .receive(on: DispatchQueue.main)
            .sink { [weak self] message in
                guard let self, let message else { return }
                showMessage(type: .success, message: message)
            }
            .store(in: &cancellables)
        
        viewModel.networkStatusSubject?
            .removeDuplicates()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] status in
                guard let self else { return }
                status == .connected ? retry() : ()
            }
            .store(in: &cancellables)
    }
    
    open func localize(with labels: [String:String]) {}
}

extension ViewController: ActivityPresentable {}

extension ViewController: MessagePresentable {}
