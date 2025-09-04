import UIKit

public extension UIView {
    func setRounded() {
        let radius = self.frame.width / 2
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
    
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    var borderColor: UIColor? {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
    func addShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowOffset = .init(width: 0, height: -1)
        layer.shadowRadius = 1
    }
    
    func shake(count: Float? = nil, for duration: TimeInterval? = nil, withTranslation translation: Float? = nil) {
        let defaultRepeatCount: Float = 2.0
        let defaultTotalDuration = 0.15
        let defaultTranslation = -10
        
        let animation = CABasicAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        
        animation.repeatCount = count ?? defaultRepeatCount
        animation.duration = (duration ?? defaultTotalDuration) / TimeInterval(animation.repeatCount)
        animation.autoreverses = true
        animation.byValue = translation ?? defaultTranslation
        layer.add(animation, forKey: "shake")
    }
    
    func addGradientBackground(firstColor: UIColor, secondColor: UIColor, startPoint: CGPoint = CGPoint(x: 0, y: 0), endPoint: CGPoint = CGPoint(x: 0, y: 0.5)) {
        clipsToBounds = true
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [firstColor.cgColor, secondColor.cgColor]
        gradientLayer.frame = self.bounds
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        gradientLayer.name = "gradientedCell"
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
    func roundSpecificCorners(corners: CACornerMask, radius: CGFloat) {
        if #available(iOS 11, *) {
            self.layer.cornerRadius = radius
            self.layer.maskedCorners = corners
        } else {
            var cornerMask = UIRectCorner()
            if corners.contains(.layerMinXMinYCorner) {
                cornerMask.insert(.topLeft)
            }
            if corners.contains(.layerMaxXMinYCorner) {
                cornerMask.insert(.topRight)
            }
            if corners.contains(.layerMinXMaxYCorner) {
                cornerMask.insert(.bottomLeft)
            }
            if corners.contains(.layerMaxXMaxYCorner) {
                cornerMask.insert(.bottomRight)
            }
            let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: cornerMask, cornerRadii: CGSize(width: radius, height: radius))
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            self.layer.mask = mask
        }
    }
    
    func roundCorners(corners: CACornerMask, radius: CGFloat) {
        layer.cornerRadius = radius
        layer.maskedCorners = corners
        
        //    layerMaxXMaxYCorner - bottom right corner
        //    layerMaxXMinYCorner - top right corner
        //    layerMinXMaxYCorner - bottom left corner
        //    layerMinXMinYCorner - top left corner
    }
    
    func rotate360Degrees(duration: CFTimeInterval = 1.0, completionDelegate: AnyObject? = nil) {
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotateAnimation.fromValue = 0.0
        rotateAnimation.toValue = CGFloat(Double.pi * 2.0)
        rotateAnimation.duration = duration
        
        if let delegate: AnyObject = completionDelegate {
            rotateAnimation.delegate = delegate as? CAAnimationDelegate
        }
        layer.add(rotateAnimation, forKey: nil)
    }
    
    func bounceAnimation(duration: CFTimeInterval = 0.3, completionDelegate: AnyObject? = nil) {
        let bounceAnimation = CAKeyframeAnimation(keyPath: "transform.scale")
        bounceAnimation.values = [1.0, 1.05, 1.0]
        bounceAnimation.duration = duration
        bounceAnimation.calculationMode = CAAnimationCalculationMode.cubic
        
        if let delegate: AnyObject = completionDelegate {
            bounceAnimation.delegate = delegate as? CAAnimationDelegate
        }
        layer.add(bounceAnimation, forKey: nil)
    }
    
    func flipFromBottomAnimation(duration: CFTimeInterval = 1.0) {
        UIView.transition(with: self,
                          duration: duration,
                          options: .transitionFlipFromBottom,
                          animations: nil,
                          completion: nil)
    }
    
    func shrink(down: Bool) {
        if down {
            UIView.animate(withDuration: 0.3) {
                self.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
            }
        } else {
            UIView.animate(withDuration: 0.3) {
                self.transform = .identity
            }
        }
    }
}
