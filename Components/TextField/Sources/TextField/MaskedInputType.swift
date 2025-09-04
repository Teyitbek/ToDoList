import Foundation

public class MaskedInputType: Codable {
    public let mask: String
    public let minLength: Int
    public let maxLength: Int
    
    public init(mask: String, minLength: Int, maxLength: Int) {
        self.mask = mask
        self.minLength = minLength
        self.maxLength = maxLength
    }
    
    public func isRequired() -> Bool {
        return minLength != -1 || maxLength != -1
    }
}

extension MaskedInputType: Equatable {
    public static func == (lhs: MaskedInputType, rhs: MaskedInputType) -> Bool {
        return lhs.mask == rhs.mask
            && lhs.minLength == rhs.minLength
            && lhs.maxLength == rhs.maxLength
    }
}
