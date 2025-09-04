import UIKit

public class CollectionView: UICollectionView {
    public init(
        collectionViewLayout: UICollectionViewLayout? = nil,
        scrollDirection: UICollectionView.ScrollDirection = .vertical,
        backgroundColor: UIColor = .clear,
        cells: [AnyClass],
        isPagingEnabled: Bool = false,
        dataSource: UICollectionViewDataSource? = nil,
        delegate: UICollectionViewDelegateFlowLayout? = nil,
        contentInset: UIEdgeInsets = .zero,
        refreshControl: UIRefreshControl? = nil) {
        if let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = scrollDirection
        }
        super.init(frame: .zero, collectionViewLayout: collectionViewLayout ?? UICollectionViewFlowLayout())
        self.backgroundColor = backgroundColor
        self.delegate = delegate
        self.dataSource = dataSource
        self.contentInset = contentInset
        self.refreshControl = refreshControl
        self.isPagingEnabled = isPagingEnabled
        self.backgroundView?.isHidden = false
        self.backgroundView?.alpha = 0
        cells.forEach { register($0, forCellWithReuseIdentifier: String(describing: $0)) }
    }
    
    public override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout = UICollectionViewLayout()) {
        super.init(frame: frame, collectionViewLayout: layout)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        if !__CGSizeEqualToSize(bounds.size, self.intrinsicContentSize) {
            self.invalidateIntrinsicContentSize()
        }
    }
    
    override public var intrinsicContentSize: CGSize {
        return contentSize
    }
}

public
extension UICollectionView {
    func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.reuseIdentifier)")
        }
        
        return cell
    }
}

extension UICollectionViewFlowLayout {
    static func with(estimatedItemSize: CGSize) -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = estimatedItemSize
        return layout
    }
}
