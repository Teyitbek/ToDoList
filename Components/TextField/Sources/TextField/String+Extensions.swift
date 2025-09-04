import Foundation
import UIKit

extension String {
    var firstUppercased: String { return prefix(1).uppercased() + dropFirst() }
    
    var onlyLetters: String {
        return String(unicodeScalars.filter(CharacterSet.letters.contains))
    }
    
    public func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return ceil(boundingBox.width)
    }
}
