import Extensions
import Fonts
import UIKit
import Base

public final class SplashCV: ContentView {
    
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
    }
    
    public override func setConstraints() {
    }
    
    func setProperties() {
        backgroundColor = .black
    }
}
