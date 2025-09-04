import Constants
import Extensions
import Fonts
import UIKit
import TextField
import Base

public protocol PincodeContentView: UIView {
    var enterPinContainerView: EnterPinContainerView { get }
}

public class PincodeCV: ContentView, PincodeContentView {
    public lazy var backgroundImageView = UIImageView.build {
        $0.image = .pincodeBackground
        $0.contentMode = .scaleAspectFill
    }
    
    public lazy var enterPinContainerView = EnterPinContainerView.build {
        $0.backgroundColor = .white
    }
    
    init() {
        super.init(frame: .zero)
        setSubviews()
        setConstraints()
        setProperties()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func setSubviews() {
        addSubview(backgroundImageView)
        addSubview(enterPinContainerView)
    }
    
    public override func setConstraints() {
        backgroundImageView.anchor(
            .leading(leadingAnchor),
            .top(topAnchor),
            .bottom(bottomAnchor),
            .trailing(enterPinContainerView.leadingAnchor),
            .widthTo(enterPinContainerView.widthAnchor, 1.3)
        )
        
        enterPinContainerView.anchor(
            .trailing(trailingAnchor),
            .top(topAnchor),
            .bottom(bottomAnchor)
        )
    }
    
    public func setProperties() {
        backgroundColor = .FFFFFF
    }
}

extension PincodeCV {
}
