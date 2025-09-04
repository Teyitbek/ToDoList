import Extensions
import UIKit

public protocol LoginContentView: UIView {
    var loginButton: UIButton { get set }
}

public class LoginCV: UIView, LoginContentView {
    public var loginButton = UIButton.build {
        $0.setTitle("Login", for: .normal)
        $0.tintColor = .red
    }
    
    init() {
        super.init(frame: .zero)
        setSubviews()
        setProperties()
        backgroundColor = .red
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension LoginCV: Customizable {
    public func setSubviews() {
        addSubview(loginButton)
    }
    
    public func setConstraints() {
        loginButton.anchor(
            .centerX(centerXAnchor),
            .width(200),
            .height(56),
            .bottom(bottomAnchor, constant: 20)
        )
    }
}
