import Extensions
import UIKit

open class CollectionViewCell<ContentView: UIView>: UICollectionViewCell {
    public let mainContentView = ContentView()
    public var shouldHighlightOnTap = true
    
    open override var isHighlighted: Bool {
        didSet {
            guard shouldHighlightOnTap else { return }
            shrink(down: isHighlighted)
            alpha = isHighlighted ? 0.8 : 1
        }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(mainContentView)
        mainContentView.fillSuperview()
        backgroundColor = .clear
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
