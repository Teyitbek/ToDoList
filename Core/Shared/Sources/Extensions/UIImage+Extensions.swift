import Foundation
import UIKit

public extension UIImage {
    func toMonochrome() -> UIImage? {
        let context = CIContext()
        guard let filter = CIFilter(name: "CIColorMonochrome") else { return nil }
        filter.setValue(CIImage(image: self), forKey: kCIInputImageKey)
        filter.setValue(CIColor(red: 0, green: 0, blue: 0), forKey: kCIInputColorKey)
        filter.setValue(1.0, forKey: kCIInputIntensityKey)
        
        guard let outputImage = filter.outputImage,
              let cgImage = context.createCGImage(outputImage, from: outputImage.extent) else {
            return nil
        }
        
        return UIImage(cgImage: cgImage)
    }
}
