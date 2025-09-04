import Foundation
 
public class RewardDetails {
    public var id: Int
    public var title: String
    public var points: Int
    public var upTo: Float
    public var image: String?
    public var products: [ProductRepresentable]?
    
    public init(id: Int, title: String, points: Int, upTo: Float, image: String? = nil, products: [ProductRepresentable]? = nil) {
        self.id = id
        self.title = title
        self.points = points
        self.upTo = upTo
        self.image = image
        self.products = products
    }
}

extension RewardDetails: NSCopying {
    public func copy(with zone: NSZone? = nil) -> Any {
        let copy = RewardDetails(id: id, title: title, points: points, upTo: upTo, image: image, products: products)
        return copy
    }
}
