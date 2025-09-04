import ActivityIndicator
import KeyboardManager
import SwiftMessages
import UIKit
import MessageView
import Base
import LocalizationManager

public final class PincodeVC: ViewController<PincodeCV, PincodeVM> {
    override public func viewDidLoad() {
        super.viewDidLoad()
    }
    
    public override func bindVM() {
        super.bindVM()
        viewModel.pinCodeErrorSubject
            .receive(on: DispatchQueue.main)
            .sink { [weak self] error in
                self?.contentView.enterPinContainerView.pincodeView.reset()
                self?.contentView.enterPinContainerView.warningView(isHidden: false, warningText: error.localizedDescription)
            }
            .store(in: &viewModel.cancellables)
    }
    
    public override func bindCV() {
        super.bindCV()
        contentView.enterPinContainerView.locationButton.locationLabel.text = viewModel.location?.name
        contentView.enterPinContainerView.pincodeView.delegate = self
    }
    
    public override func localize(with labels: [String : String]) {
        contentView.enterPinContainerView.titleLabel.text = labels[L10n.Auth.enterPin]
        contentView.enterPinContainerView.warningView.titleLabel.text = labels[L10n.Message.error]
    }
}

@objc
extension PincodeVC {
}

extension PincodeVC: PincodeViewDelegate {
    func onPinEntered(_ pin: String) {
        if pin == "0000" { // TODO: - For test only. Remove later
            viewModel.resetLocation()
            return
        }
        
        viewModel.login(pincode: pin)
    }
}
