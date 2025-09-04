import Foundation
import UIKit

public extension String {
    var stripeReaderDisplayName: String {
        switch self {
        case "stripe_m2": return "Stripe M2"
        case "chipper_2x": return "Chipper 2X"
        case "wisepos_e": return "WisePOS E"
        case "verifone_p400": return "Verifone P400"
        case "stripe_s700": return "Stripe S700"
        case "stripe_reader_api": return "Stripe Reader API"
        default: return self.replacingOccurrences(of: "_", with: " ").capitalized
        }
    }
    
    func toDate(withFormat format: String = "yyyy-MM-dd HH:mm:ss") -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatter.locale = Locale(identifier: "en_US")
        let date = dateFormatter.date(from: self)
        return date
    }
    
    func validPhoneNumber() -> String {
        var phoneNumber = self
        phoneNumber = phoneNumber.replacingOccurrences(of: " ", with: "")
        phoneNumber = phoneNumber.replacingOccurrences(of: "(", with: "")
        phoneNumber = phoneNumber.replacingOccurrences(of: ")", with: "")
        phoneNumber = phoneNumber.replacingOccurrences(of: "-", with: "")
        return phoneNumber
    }
    
    func htmlAttributedString() -> NSMutableAttributedString {
        guard let data = self.data(using: String.Encoding.utf8, allowLossyConversion: false) else {
            return NSMutableAttributedString()
        }
        guard let formattedString = try? NSMutableAttributedString(
            data: data,
            options: [
                .documentType: NSAttributedString.DocumentType.html,
                .characterEncoding: String.Encoding.utf8.rawValue
            ],
            documentAttributes: nil
        ) else {
            return NSMutableAttributedString()
        }
        return formattedString
    }
    
    typealias LabelTextSize = (width: CGFloat, height: CGFloat)
    
    func heightForLabel(font: UIFont, width: CGFloat) -> LabelTextSize {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude) // Unbounded height
        let boundingBox = self.boundingRect(
            with: constraintRect,
            options: [.usesLineFragmentOrigin, .usesFontLeading], // Ensure proper line wrapping and spacing
            attributes: [.font: font],
            context: nil
        )
        return (ceil(boundingBox.width), ceil(boundingBox.height)) // Round up to avoid clipping
    }
    
    func convertToImage(color: UIColor, font: UIFont) -> UIImage {
        let attributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .foregroundColor: color
        ]
        let size = (self as NSString).size(withAttributes: attributes)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        (self as NSString).draw(at: .zero, withAttributes: attributes)
        let image = UIGraphicsGetImageFromCurrentImageContext() ?? UIImage()
        UIGraphicsEndImageContext()
        return image
    }
}
