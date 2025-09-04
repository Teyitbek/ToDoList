import Extensions
import Fonts
import UIKit
import Base

public protocol SplashContentView: UIView {
    var imageView: UIImageView { get set }
}

public final class SplashCV: ContentView, SplashContentView {
    public var imageView = UIImageView.build {
        $0.contentMode = .scaleAspectFill
        $0.image = .splash
        $0.backgroundColor = .red
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
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
    
    public override func setSubviews() {
        addSubview(imageView)
    }
    
    public override func setConstraints() {
        imageView.fillSuperview()
    }
    
    func setProperties() {
        backgroundColor = .green
    }
}
