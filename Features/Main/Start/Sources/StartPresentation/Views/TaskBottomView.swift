import Constants
import Extensions
import Fonts
import UIKit

public class TaskBottomView: UIView {
    lazy var notestLabel = makeLabel()
    lazy var addNewNoteButton = makeButton()
    private lazy var blurView = makeBlurView()
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        setSubviews()
        setConstraints()
        setProperties()
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        blurView.frame = bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension TaskBottomView: Customizable {
    public func setSubviews() {
        addSubview(blurView)
        addSubview(notestLabel)
        addSubview(addNewNoteButton)
    }
    
    public func setConstraints() {
        notestLabel.anchor(
            .centerX(centerXAnchor),
            .centerY(addNewNoteButton.centerYAnchor)
        )
        
        addNewNoteButton.anchor(
            .top(topAnchor, constant: Constants.UI.padding14),
            .trailing(trailingAnchor, constant: Constants.UI.viewsLeadingTrailing),
            .width(Constants.UI.padding32),
            .heightToWidth(1)
        )
    }
    
    public func setProperties() {
    }
}
private extension TaskBottomView {
    func makeBlurView() -> UIVisualEffectView {
        let blurEffect = UIBlurEffect(style: .dark)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurView.alpha = 0.9
        return blurView
    }
    
    func makeLabel() -> UILabel {
        let label = UILabel()
        label.textColor = .white
        label.font = Fonts.murecho.font(forTextStyle: .footnote)
        label.textAlignment = .center
        return label
    }
    
    func makeButton() -> UIButton {
        let button = UIButton(type: .system)
        return button
    }
}
