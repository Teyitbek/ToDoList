import Constants
import UIKit

public final class LocationButton: UIButton {
    lazy var stackView = UIStackView.build {
        $0.axis = .horizontal
        $0.isUserInteractionEnabled = false
    }
    
    lazy var locationLabel = UILabel.build {
        $0.text = "Select Store"
        $0.font = .systemFont(ofSize: Constants.Constraints.HeightBased._14, weight: .bold)
        $0.textColor = ._1_D_1_E_26
        $0.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        $0.setContentHuggingPriority(.defaultLow, for: .horizontal)
    }
    
    lazy var locationImageView = UIImageView.build {
        $0.image = .location
        $0.contentMode = .scaleAspectFit
        $0.setContentCompressionResistancePriority(.required, for: .horizontal)
        $0.setContentHuggingPriority(.required, for: .horizontal)
    }
    
    public lazy var arrowImageView = UIImageView.build {
        $0.image = .arrowDown
        $0.contentMode = .scaleAspectFit
        $0.setContentCompressionResistancePriority(.required, for: .horizontal)
        $0.setContentHuggingPriority(.required, for: .horizontal)
    }
    
    public override var isHighlighted: Bool {
         get {
             return super.isHighlighted
         }
        
         set {
             if newValue {
                 locationLabel.alpha = 0.5
                 arrowImageView.alpha = 0.5
                 locationImageView.alpha = 0.5
             } else {
                 locationLabel.alpha = 1.0
                 arrowImageView.alpha = 1.0
                 locationImageView.alpha = 1.0
             }
             super.isHighlighted = newValue
         }
     }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setSubviews()
        setConstraints()
        setProperties()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        stackView.spacing = Constants.Constraints.WidthBased._8
    }
}

extension LocationButton {
    func setSubviews() {
        addSubview(stackView)
        stackView.addArrangedSubviews(locationImageView, locationLabel, arrowImageView)
    }
    
    func setConstraints() {
        stackView.fillSuperview(padding: .init(top: Constants.Constraints.WidthBased._10,
                                               left: Constants.Constraints.WidthBased._10,
                                               bottom: Constants.Constraints.WidthBased._10,
                                               right: Constants.Constraints.WidthBased._10))
    }
    
    func setProperties() {
        clipsToBounds = true
        backgroundColor = .EBEDF_5
        cornerRadius = Constants.Constraints.HeightBased._12
    }
}
