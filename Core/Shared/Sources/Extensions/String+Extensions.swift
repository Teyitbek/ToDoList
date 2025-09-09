import Foundation
import UIKit

public extension String {
    func toDate(withFormat format: String = "yyyy-MM-dd HH:mm:ss") -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatter.locale = Locale(identifier: "en_US")
        let date = dateFormatter.date(from: self)
        return date
    }
    
    func customAttributedText() -> NSAttributedString {
        let lines = self.components(separatedBy: "\n")
        let attributed = NSMutableAttributedString(string: self)
        for (index, line) in lines.enumerated() {
            let range = (self as NSString).range(of: line)
            let style: UIFont.TextStyle = index == 0 ? .headline : .subheadline
            let font = UIFont.preferredFont(forTextStyle: style)
            let color = index == 0 ? UIColor.white : UIColor.white.withAlphaComponent(0.8)
            attributed.addAttributes([.font: font, .foregroundColor: color], range: range)
        }
        return attributed
    }
}
