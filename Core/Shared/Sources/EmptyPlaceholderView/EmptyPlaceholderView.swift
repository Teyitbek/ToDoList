import Constants
import Extensions
import Fonts
import UIKit

public class EmptyPlaceholderView: UIView {    
    public lazy var emptyBoxImageView = makeEmptyBoxImageView()
    public lazy var titleLabel = makeTitleLabel()
    public lazy var subtitleLabel = makeSubtitleLabel()
    public lazy var actionButton = makeActionButton()
    
    private let emptyBoxImageViewHeight: CGFloat = Constants.Constraints.HeightBased._210
    private let emptyBoxImageViewWidth: CGFloat = Constants.Constraints.HeightBased._210
    private let emptyBoxImageViewCenterY: CGFloat = Constants.Constraints.HeightBased._80
    private let titleLabelTop: CGFloat = Constants.Constraints.HeightBased._12
    private let actionButtonTop: CGFloat = Constants.Constraints.HeightBased._8
    private let titleLabelLeadingTrailing: CGFloat = Constants.Constraints.HeightBased._48
    
    public init() {
        super.init(frame: .zero)
        setSubviews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension EmptyPlaceholderView: Customizable {
    public func setSubviews() {
        addSubview(emptyBoxImageView)
        addSubview(titleLabel)
        addSubview(subtitleLabel)
        addSubview(actionButton)
    }
    
    public func setConstraints() {
        emptyBoxImageView.anchor(
            .centerY(centerYAnchor, constant: -emptyBoxImageViewCenterY),
            .centerX(centerXAnchor),
            .height(emptyBoxImageViewHeight),
            .width(emptyBoxImageViewWidth)
        )
        
        titleLabel.anchor(
            .top(emptyBoxImageView.bottomAnchor, constant: titleLabelTop),
            .centerX(centerXAnchor),
            .widthTo(widthAnchor, 0.8)
        )
        
        subtitleLabel.anchor(
            .top(titleLabel.bottomAnchor, constant: titleLabelTop / 2),
            .centerX(centerXAnchor),
            .widthTo(widthAnchor, 0.8)
        )
        
        actionButton.anchor(
            .top(subtitleLabel.bottomAnchor, constant: actionButtonTop),
            .centerX(centerXAnchor)
        )
    }
}

private extension EmptyPlaceholderView {
    func makeEmptyBoxImageView() -> UIImageView {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view
    }
    
    func makeTitleLabel() -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = Fonts.murecho.font(forTextStyle: .title3)
        label.textColor = UIColor.black
        label.textAlignment = .center
        return label
    }
    
    func makeSubtitleLabel() -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: Constants.Constraints.HeightBased._14, weight: .regular)
        label.textAlignment = .center
        return label
    }
    
    func makeActionButton() -> UIButton {
        let button = UIButton(type: .system)
        button.contentHorizontalAlignment = .center
        button.setTitleColor(UIColor.black, for: .normal)
        return button
    }
}
