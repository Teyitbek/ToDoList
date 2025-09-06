import Constants
import Extensions
import Fonts
import UIKit

public class NoteTVCellCV: UIView {
    lazy var selectButton = makeButton()
    private lazy var stackView = makeStackView()
    lazy var titleLabel = makeTitleLabel()
    lazy var subtitleLabel = makeSubTitleLabel()
    lazy var dateLabel = makeSubTitleLabel()
    private lazy var bottomLineView = makeBottomLineView()
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        setSubviews()
        setConstraints()
        setProperties()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension NoteTVCellCV: Customizable {
    public func setSubviews() {
        addSubview(selectButton)
        addSubview(stackView)
        stackView.addArrangedSubviews(
            titleLabel,
            subtitleLabel,
            dateLabel
        )
        addSubview(bottomLineView)
    }
    
    public func setConstraints() {
        selectButton.anchor(
            .centerY(titleLabel.centerYAnchor),
            .leading(leadingAnchor, constant: Constants.UI.padding20),
            .width(Constants.UI.padding24),
            .heightToWidth(1)
        )
        
        stackView.anchor(
            .top(topAnchor, constant: Constants.UI.padding8),
            .leading(selectButton.trailingAnchor, constant: Constants.UI.padding10),
            .trailing(trailingAnchor, constant: Constants.UI.padding20),
            .bottom(bottomAnchor, constant: Constants.UI.padding8)
        )
        
        bottomLineView.anchor(
            .leading(leadingAnchor, constant: Constants.UI.padding20),
            .trailing(trailingAnchor, constant: Constants.UI.padding20),
            .bottom(bottomAnchor),
            .height(1)
        )
    }
    
    public func setProperties() {
        backgroundColor = .clear
    }
}
private extension NoteTVCellCV {
    func makeButton() -> UIButton {
        let button = UIButton(type: .custom)
        return button
    }
    
    func makeStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }
    
    func makeTitleLabel() -> UILabel {
        let label = UILabel()
        label.font = Fonts.murecho.font(forTextStyle: .title3)
        label.textColor = .white
        return label
    }
    
    func makeSubTitleLabel() -> UILabel {
        let label = UILabel()
        label.font = Fonts.murecho.font(forTextStyle: .footnote)
        label.textColor = .white.withAlphaComponent(0.6)
        label.numberOfLines = 2
        return label
    }
    
    func makeBottomLineView() -> UIView {
        return UIView(backgroundColor: .white.withAlphaComponent(0.6))
    }
}
