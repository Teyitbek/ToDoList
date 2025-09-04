import Foundation
import UIKit

public extension UIImageView {
    func setInitialsAvatar(name: String,
                           size: CGSize? = nil,
                           backgroundColor: UIColor = UIColor(red: 0.922, green: 0.929, blue: 0.961, alpha: 1),
                           textColor: UIColor = UIColor(red: 0.114, green: 0.118, blue: 0.149, alpha: 1)) {
        let targetSize = size ?? self.bounds.size
        guard targetSize.width > 0, targetSize.height > 0 else { return }

        let initials = name
            .components(separatedBy: .whitespaces)
            .compactMap { $0.first }
            .prefix(2)
            .map { String($0) }
            .joined()
            .uppercased()

        let renderer = UIGraphicsImageRenderer(size: targetSize)
        let image = renderer.image { context in
            let rect = CGRect(origin: .zero, size: targetSize)

            // Draw circle background
            backgroundColor.setFill()
            UIBezierPath(ovalIn: rect).fill()

            // Draw initials
            let fontSize = targetSize.width * 0.4
            let attributes: [NSAttributedString.Key: Any] = [
                .font: UIFont.systemFont(ofSize: fontSize, weight: .medium),
                .foregroundColor: textColor
            ]

            let textSize = initials.size(withAttributes: attributes)
            let textRect = CGRect(
                x: (targetSize.width - textSize.width) / 2,
                y: (targetSize.height - textSize.height) / 2,
                width: textSize.width,
                height: textSize.height
            )
            initials.draw(in: textRect, withAttributes: attributes)
        }

        self.image = image
        self.layer.cornerRadius = targetSize.width / 2
        self.clipsToBounds = true
        self.contentMode = .scaleAspectFill
    }
}
