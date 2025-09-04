import UIKit

open class CollectionReusableView<ContentView: UIView>: UICollectionReusableView {
    public let contentView = ContentView()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(contentView)
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
    }
}

public extension UICollectionView {
    func dequeueReusableView<T: UICollectionReusableView>(for indexPath: IndexPath, _ kind: String) -> T {
        guard let cell = dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.reuseIdentifier)")
        }
        
        return cell
    }
}

//public extension UIView {
//    static var reuseIdentifier: String {
//        return String(describing: self)
//    }
//}
