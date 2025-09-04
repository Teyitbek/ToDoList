import Extensions
import UIKit

public protocol SplashContentView: UIView {
    var imageView: UIImageView { get set }
}

public class SplashCV: UIView, SplashContentView {
    public var imageView = UIImageView()
   
    init() {
        super.init(frame: .zero)
        setSubviews()
        setProperties()
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SplashCV: Customizable {
    public func setSubviews() {
        addSubview(imageView)
    }
    
    public func setConstraints() {
        imageView.anchor(
            .centerX(centerXAnchor),
            .centerY(centerYAnchor, constant: -40)
        )
    }
    
    public func setProperties() {
        imageView.image = UIImage(named: "logo", in: .module, with: .none)
        backgroundColor = UIColor(named: "background", in: .module, compatibleWith: .none)
    }
}
