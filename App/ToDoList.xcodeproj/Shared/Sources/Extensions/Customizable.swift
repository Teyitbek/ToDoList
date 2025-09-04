import Foundation
import UIKit

public protocol Customizable where Self: UIView {
    func setSubviews()
    func setConstraints()
    func setProperties()
}

public extension Customizable {
    func setProperties() {
        backgroundColor = .white
    }
}
