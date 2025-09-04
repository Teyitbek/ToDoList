import UIKit

public enum TextfieldState {
    case `default`
    case focused
    case success
    case error
    public var borderColor: UIColor {
        switch self {
        case .default: return .E_1_E_3_EB
        case .focused: return .E_1_E_3_EB
        case .success: return .E_1_E_3_EB
        case .error: return .systemRed
        }
    }
}
