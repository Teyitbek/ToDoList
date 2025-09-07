import Constants
import Extensions
import Fonts
import UIKit

public class PreviewCV: UIView {
    lazy var titleLabel = makeTitleLabel()
    lazy var subtitleLabel = makeSubTitleLabel()
    lazy var dateLabel = makeSubTitleLabel()
        
    override public init(frame: CGRect) {
        super.init(frame: frame)
        setSubviews()
        setConstraints()
        setProperties()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setSubviews() {
        addSubview(titleLabel)
        addSubview(subtitleLabel)
        addSubview(dateLabel)
    }
    
    public func setConstraints() {
        titleLabel.anchor(
            .top(topAnchor, constant: Constants.UI.padding20),
            .leading(leadingAnchor, constant: Constants.UI.padding20),
            .trailing(trailingAnchor, constant: Constants.UI.padding20)
        )
        
        subtitleLabel.anchor(
            .top(titleLabel.bottomAnchor, constant: Constants.UI.padding8),
            .leading(leadingAnchor, constant: Constants.UI.padding20),
            .trailing(trailingAnchor, constant: Constants.UI.padding20)
        )
        
        dateLabel.anchor(
            .top(subtitleLabel.bottomAnchor, constant: Constants.UI.padding8),
            .leading(leadingAnchor, constant: Constants.UI.padding20),
            .trailing(trailingAnchor, constant: Constants.UI.padding20)
        )
    }
    
    public func setProperties() {
        backgroundColor = .black.withAlphaComponent(0.9)
    }
}
private extension PreviewCV {
    func makeTitleLabel() -> UILabel {
        let label = UILabel()
        label.font = Fonts.murecho.font(forTextStyle: .title3)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }
    
    func makeSubTitleLabel() -> UILabel {
        let label = UILabel()
        label.font = Fonts.murecho.font(forTextStyle: .footnote)
        label.textColor = .white.withAlphaComponent(0.6)
        label.numberOfLines = 0
        return label
    }
}
