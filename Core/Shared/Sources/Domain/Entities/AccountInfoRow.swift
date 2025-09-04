import Foundation
import UIKit

public enum AccountInfoRow: Int, CaseIterable {
    case fullname
    case phoneNumber
    case email
    case birthday
    
    public var title: String {
        switch self {
        case .fullname: "Full name"
        case .phoneNumber: "Phone number"
        case .email: "Email"
        case .birthday: "Date of Birth"
        }
    }
}
