import TableView
import Domain
import UIKit

@MainActor
protocol NoteTVCellDelegate: AnyObject {
    func didTap(_ cell: NoteTVCell)
}

open class NoteTVCell: TableViewCell<NoteTVCellCV> {
    weak var delegate: NoteTVCellDelegate?
    
    override public init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        mainContentView.selectButton.addTarget(self, action: #selector(didTap), for: .touchUpInside)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func prepareForReuse() {
        super.prepareForReuse()
        mainContentView.selectButton.setImage(nil, for: .normal)
        mainContentView.doneView.isHidden = true
    }
    
    func setup(with model: TodoRepresentable) {
        mainContentView.selectButton.setImage(model.completed ? .circleSelected : .circleUnselected, for: .normal)
        mainContentView.dateLabel.text = Date().toString()
        mainContentView.dateLabel.alpha = model.completed ? 0.5 : 1
        mainContentView.doneView.isHidden = !model.completed

        mainContentView.titleLabel.attributedText = model.todo?.customAttributedText()
        mainContentView.titleLabel.alpha = model.completed ? 0.5 : 1

        mainContentView.titleLabel.layoutIfNeeded()
        mainContentView.doneViewConstraints?.width?.constant = calculateTitleWidth()
    }
    
    private func calculateTitleWidth() -> CGFloat {
        guard let font = mainContentView.titleLabel.font else { return 0 }
        let text = mainContentView.titleLabel.text ?? ""
        
        let maxWidth = mainContentView.titleLabel.frame.width > 0 ? mainContentView.titleLabel.frame.width : mainContentView.titleLabel.intrinsicContentSize.width
        let maxSize = CGSize(width: maxWidth, height: .greatestFiniteMagnitude)
        
        let boundingRect = NSString(string: text).boundingRect(
            with: maxSize,
            options: [.usesLineFragmentOrigin, .usesFontLeading],
            attributes: [.font: font],
            context: nil
        )
        return ceil(boundingRect.width) + 10
    }
}
@objc
extension NoteTVCell {
    func didTap() {
        delegate?.didTap(self)
    }
}
