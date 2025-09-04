import Foundation

// swiftlint:disable all
public protocol TextFieldValidator {
    var error: TextFieldValidationError { get set }
    func validate(_ value: String) throws -> String
}

public enum TextFieldType: Equatable {
    case email
    case fullname
    case name
    case password
    case quantity
    case validationCode
    case zipCode
    case phoneNumber
    case number
    case amount(minAmount: Double = 0, maxAmount: Double = Double.greatestFiniteMagnitude, minAmountInvalidText: String = "", maxAmountInvalidText: String = "")
    case custom(regex: String)
}


