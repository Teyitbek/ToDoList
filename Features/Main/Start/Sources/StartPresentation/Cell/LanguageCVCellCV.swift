import Constants
import Extensions
import Fonts
import UIKit

public class LanguageCVCellCV: UIView {
    lazy var coverView = makeCoverView()
    lazy var imageView = makeImageView()
    lazy var titleLabel = makeTitleLabel()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setSubviews()
        setConstraints()
        setProperties()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension LanguageCVCellCV: Customizable {
    public func setSubviews() {
        addSubview(coverView)
        addSubview(imageView)
        addSubview(titleLabel)
    }
    
    public func setConstraints() {
        imageView.anchor(
            .centerY(centerYAnchor),
            .width(Constants.Constraints.WidthBased._40)
        )
        
        titleLabel.anchor(
            .centerY(centerYAnchor, constant: -Constants.Constraints.HeightBased._2),
            .leading(imageView.trailingAnchor, constant: Constants.Constraints.WidthBased._12),
            .trailing(trailingAnchor, constant: Constants.Constraints.WidthBased._24)
        )
        
        coverView.fillSuperview()
    }
    
    public func setProperties() {
        backgroundColor = .F_5_F_6_FA
        cornerRadius = Constants.Constraints.HeightBased._34
    }
    
    func selected(_ isSelected: Bool) {
        coverView.backgroundColor = isSelected ? ._3_DBD_5_C.withAlphaComponent(0.20) : .F_5_F_6_FA
        coverView.borderWidth = isSelected ? 1 : 0
    }
}
private extension LanguageCVCellCV {
    func makeImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        return imageView
    }
    
    func makeTitleLabel() -> UILabel {
        let label = UILabel()
        label.textColor = ._1_D_1_E_26
        label.font = Fonts.murecho.font(forTextStyle: .title2)
        return label
    }
    
    func makeCoverView() -> UIView {
        let view = UIView(backgroundColor: .FFFFFF)
        view.borderColor = ._31974_A
        view.cornerRadius = Constants.Constraints.HeightBased._34
        return view
    }
}
