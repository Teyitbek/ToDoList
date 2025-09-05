import UIKit
import Extensions

open class TableViewCell<ContentView: UIView>: UITableViewCell {
    public let mainContentView = ContentView()
    private let highlightionView = UIView()
   
    open var shouldHighlightOnTap: Bool {
        return false
    }
    
    var highlightionViewConstraints: AnchoredConstraints?
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.contentView.addSubview(mainContentView)
        self.mainContentView.fillSuperview()
        self.highlightionView.alpha = 0
        self.contentView.addSubview(highlightionView)
        highlightionView.backgroundColor = UIColor.white.withAlphaComponent(0.4)
        highlightionViewConstraints = highlightionView.fillSuperview()
        self.backgroundColor = .clear
        highlightionView.isUserInteractionEnabled = false
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    public override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        guard shouldHighlightOnTap else { return }
        UIView.animate(withDuration: 0.1) {
            self.highlightionView.alpha = highlighted ? 1 : 0
        }
    }
}
