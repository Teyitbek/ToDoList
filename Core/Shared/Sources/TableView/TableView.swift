import UIKit

open class TableView: UITableView {
    public init(
        style: UITableView.Style = .plain,
        backgroundColor: UIColor = .clear,
        allowsSelection: Bool = true,
        allowsMultipleSelectionDuringEditing: Bool = false,
        cells: [AnyClass] = [],
        automaticDimentioned: Bool = false,
        delegate: UITableViewDelegate? = nil,
        dataSource: UITableViewDataSource? = nil,
        contentInset: UIEdgeInsets = .zero
    ) {
        super.init(frame: .zero, style: style)
        
        if automaticDimentioned {
            self.rowHeight = UITableView.automaticDimension
            self.estimatedRowHeight = UITableView.automaticDimension
        }
        self.contentInset = contentInset
        if let delegate = delegate {
            self.delegate = delegate
        }
        if let dataSource = dataSource {
            self.dataSource = dataSource
        }
        self.backgroundColor = backgroundColor
        self.allowsSelection = allowsSelection
        self.allowsMultipleSelectionDuringEditing = allowsMultipleSelectionDuringEditing
        cells.forEach { register($0, forCellReuseIdentifier: String(describing: $0)) }
        self.showsVerticalScrollIndicator = false
        translatesAutoresizingMaskIntoConstraints = false
        separatorStyle = .none
        alwaysBounceVertical = true
        self.backgroundView?.isHidden = false
        self.backgroundView?.alpha = 0
    }
    
    public override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override open var intrinsicContentSize: CGSize {
        self.layoutIfNeeded()
        return contentSize
    }
    
    override open var contentSize: CGSize {
        didSet {
            self.invalidateIntrinsicContentSize()
        }
    }
}

public extension UITableView {
    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.reuseIdentifier)")
        }
        
        return cell
    }
    
    func showPlaceholderView() {
        self.backgroundView?.isHidden = false
        self.backgroundView?.alpha = 1
    }
    
    func hidePlaceholderView() {
        self.backgroundView?.isHidden = true
        self.backgroundView?.alpha = 0
    }
}

extension UIView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
