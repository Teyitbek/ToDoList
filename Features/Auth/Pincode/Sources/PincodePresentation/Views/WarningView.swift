import Constants
import Foundation
import Fonts
import UIKit

public final class WarningView: UIView {
    let imageView = UIImageView.build {
        $0.image = .warning
        $0.contentMode = .scaleAspectFit
        $0.setContentCompressionResistancePriority(.required, for: .horizontal)
        $0.setContentHuggingPriority(.required, for: .horizontal)
    }
    
    lazy var titleLabel = UILabel.build {
        $0.text = "Error"
        $0.textColor = ._1_D_1_E_26
        $0.font = .systemFont(ofSize: Constants.Constraints.HeightBased._14, weight: .bold)
        $0.numberOfLines = 0
    }
    
    lazy var subTitleLabel = UILabel.build {
        $0.textColor = ._1_D_1_E_26
        $0.font = .systemFont(ofSize: Constants.Constraints.HeightBased._14, weight: .regular)
        $0.numberOfLines = 0
    }
    
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
    }
}

extension WarningView {
    func setSubviews() {
        addSubview(imageView)
        addSubview(titleLabel)
        addSubview(subTitleLabel)
    }
    
    func setConstraints() {
        imageView.anchor(
            .leading(leadingAnchor, constant: Constants.Constraints.WidthBased._12),
            .top(topAnchor, constant: Constants.Constraints.HeightBased._12),
            .width(Constants.Constraints.WidthBased._20),
            .heightToWidth(1)
        )
        
        titleLabel.anchor(
            .leading(imageView.trailingAnchor, constant: Constants.Constraints.WidthBased._12),
            .top(topAnchor, constant: Constants.Constraints.HeightBased._12),
            .trailing(trailingAnchor, constant: Constants.Constraints.WidthBased._12)
        )
        
        subTitleLabel.anchor(
            .leading(imageView.trailingAnchor, constant: Constants.Constraints.WidthBased._12),
            .top(titleLabel.bottomAnchor, constant: Constants.Constraints.HeightBased._4),
            .trailing(trailingAnchor, constant: Constants.Constraints.WidthBased._12),
            .bottom(bottomAnchor, constant: Constants.Constraints.HeightBased._12)
        )
    }
    
    func setProperties() {
        clipsToBounds = true
        cornerRadius = Constants.Constraints.HeightBased._8
        backgroundColor = .FFEDC_9
    }
}
