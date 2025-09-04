import Foundation

struct AmountValidator: TextFieldValidator {
    var error: TextFieldValidationError
    
    let minAmount: Double
    let maxAmount: Double
    let minAmountInvalidText: String
    let maxAmountInvalidText: String

    @discardableResult
    func validate(_ value: String) throws -> String {
        do {
            let expression = try NSRegularExpression(
                pattern: "^([0-9]*[1-9][0-9]*(\\.[0-9]+)?|[0]+\\.[0-9]*[1-9][0-9]*)$",
                options: .caseInsensitive
            )
            
            guard let amount = Double(value) else {
                throw error
            }
            
            guard amount >= minAmount else {
                throw TextFieldValidationError(
                    minAmountInvalidText.replacingOccurrences(of: "{amount}", with: String(minAmount))
                )
            }
            
            guard amount <= maxAmount else {
                throw TextFieldValidationError(
                    maxAmountInvalidText.replacingOccurrences(of: "{amount}", with: String(maxAmount))
                )
            }
            
            if expression.firstMatch(in: value, options: [], range: NSRange(location: 0, length: value.count)) == nil {
                throw error
            }
        } catch {
            throw error
        }
        return value
    }
}
