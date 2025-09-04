import Constants
import Foundation
import Fonts
import UIKit

public final class EnterPinContainerView: UIView {
    lazy var titleLabel = UILabel.build {
        $0.textColor = ._1_D_1_E_26
        $0.font = Fonts.murecho.font(forTextStyle: .largeTitle)
    }
    lazy var locationButton = LocationButton.build {
        $0.showsMenuAsPrimaryAction = true
        $0.isEnabled = false
        $0.arrowImageView.isHidden = true
    }
    lazy var warningView = WarningView.build {
        $0.isHidden = true
    }
    lazy var stackView = UIStackView.build {
        $0.axis = .vertical
    }
    
    lazy var pincodeView = PincodeView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setSubviews()
        setProperties()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        stackView.spacing = Constants.Constraints.HeightBased._24
    }
    
    func warningView(isHidden: Bool, warningText: String = "") {
        if isHidden {
            self.warningView.alpha = 1
            UIView.animate(withDuration: 0.2, animations: {
                self.warningView.alpha = 0
                self.stackView.layoutIfNeeded()
            }) { _ in
                self.warningView.isHidden = true
            }
        } else {
            self.warningView.alpha = 0
            self.warningView.isHidden = false
            
            UIView.animate(withDuration: 0.2, animations: {
                self.warningView.alpha = 1
                self.stackView.layoutIfNeeded()
            })
        }
        warningView.subTitleLabel.text = warningText
        stackView.layoutIfNeeded()
    }
}

extension EnterPinContainerView {
    func setSubviews() {
        addSubview(stackView)
        stackView.addArrangedSubviews(
            titleLabel,
            locationButton,
            warningView,
            pincodeView
        )
    }
    
    func setConstraints() {
        stackView.anchor(
            .centerX(centerXAnchor),
            .centerY(centerYAnchor)
        )
    }
    
    func setProperties() {
        clipsToBounds = true
    }
}
