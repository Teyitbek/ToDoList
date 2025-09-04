import UIKit

public extension UIColor {
    convenience init?(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        // Remove "#" if present
        if hexSanitized.hasPrefix("#") {
            hexSanitized.removeFirst()
        }

        // Must be 6 or 8 characters (RGB or ARGB)
        guard hexSanitized.count == 6 || hexSanitized.count == 8 else { return nil }

        var rgb: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgb)

        let hasAlpha = hexSanitized.count == 8
        let a = hasAlpha ? CGFloat((rgb & 0xFF000000) >> 24) / 255.0 : 1.0
        let r = CGFloat((rgb & 0x00FF0000) >> 16) / 255.0
        let g = CGFloat((rgb & 0x0000FF00) >> 8) / 255.0
        let b = CGFloat(rgb & 0x000000FF) / 255.0

        self.init(red: r, green: g, blue: b, alpha: a)
    }
}
