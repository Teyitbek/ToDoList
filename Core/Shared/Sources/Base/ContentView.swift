import UIKit

public protocol ContentViewRepresentable: UIView {
    func setSubviews()
    func setConstraints()
}

open class ContentView: UIView, ContentViewRepresentable {
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setSubviews()
        setConstraints()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func setSubviews() {}
    
    open func setConstraints() {}
    
    deinit {
        print("===> \(type(of: self)) is deinited")
    }
}
