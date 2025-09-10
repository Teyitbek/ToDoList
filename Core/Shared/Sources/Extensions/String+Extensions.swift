import Foundation
import UIKit

public extension String {
    func customAttributedText(withstrikethrough: Bool = false) -> NSAttributedString {
        let lines = self.components(separatedBy: "\n")
        let attributed = NSMutableAttributedString(string: self)
        
        for (index, line) in lines.enumerated() {
            let range = (self as NSString).range(of: line)
            let style: UIFont.TextStyle = index == 0 ? .headline : .subheadline
            let font = UIFont.preferredFont(forTextStyle: style)
            let color = index == 0 ? UIColor.white : UIColor.white.withAlphaComponent(0.8)
            
            var attributes: [NSAttributedString.Key: Any] = [
                .font: font,
                .foregroundColor: color
            ]
            
            if withstrikethrough {
                attributes[.strikethroughStyle] = NSUnderlineStyle.single.rawValue
            }
            
            attributed.addAttributes(attributes, range: range)
        }
        return attributed
    }
}
