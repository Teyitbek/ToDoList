import TableView
import UIKit

@MainActor
protocol NoteTVCellDelegate: AnyObject {
    func didTap(_ cell: NoteTVCell)
}

open class NoteTVCell: TableViewCell<NoteTVCellCV> {
    weak var delegate: NoteTVCellDelegate?
    
    override public init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        mainContentView.checkImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTap)))
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func setup(with model: ToDoModel) {
        mainContentView.checkImageView.image = model.completed ? .circleSelected : .circleUnselected
        mainContentView.titleLabel.text = model.todo
        mainContentView.subtitleLabel.text = "Valet data can only be accessed while the device is unlocked. This is recommended for data that only needs to be accessible while the application is in the foreground. Valet data with this attribute will never migrate to a new device, so these items will be missing after a backup is restored to a new device."
        mainContentView.dateLabel.text = "5 september 2025"
    }
}
@objc
extension NoteTVCell {
    func didTap() {
        delegate?.didTap(self)
    }
}
