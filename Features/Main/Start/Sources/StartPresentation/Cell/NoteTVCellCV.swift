import Constants
import Extensions
import Fonts
import UIKit

public class NoteTVCellCV: UIView {
    lazy var selectButton = makeButton()
    private lazy var stackView = makeStackView()
    lazy var titleLabel = makeTitleLabel()
    lazy var doneView = makeLineView(alpha: 0.3)
    lazy var subtitleLabel = makeSubTitleLabel()
    lazy var dateLabel = makeSubTitleLabel()
    private lazy var bottomLineView = makeLineView(alpha: 0.6)
    
    var doneViewConstraints: AnchoredConstraints?
    
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
        addSubview(doneView)
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
            .top(topAnchor, constant: Constants.UI.padding12),
            .leading(selectButton.trailingAnchor, constant: Constants.UI.padding12),
            .trailing(trailingAnchor, constant: Constants.UI.padding20),
            .bottom(bottomAnchor, constant: Constants.UI.padding8)
        )
        
        doneViewConstraints = doneView.anchor(
            .centerY(titleLabel.centerYAnchor),
            .leading(titleLabel.leadingAnchor, constant: -Constants.UI.padding4),
            .height(1)
        )
        doneViewConstraints?.width = doneView.widthAnchor.constraint(equalToConstant: 0)
        doneViewConstraints?.width?.isActive = true
        
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
        label.numberOfLines = 0
        return label
    }
    
    func makeSubTitleLabel() -> UILabel {
        let label = UILabel()
        label.font = Fonts.murecho.font(forTextStyle: .footnote)
        label.textColor = .white.withAlphaComponent(0.6)
        label.numberOfLines = 2
        return label
    }
    
    func makeLineView(alpha: CGFloat) -> UIView {
        return UIView(backgroundColor: .white.withAlphaComponent(alpha))
    }
}
