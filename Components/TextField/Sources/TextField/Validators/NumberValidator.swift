import Foundation

struct NumberValidator: TextFieldValidator {
    var error: TextFieldValidationError
    func validate(_ value: String) throws -> String {
        do {
            let expression = try NSRegularExpression(
                pattern: "[0-9]{1,1478}",
                options: .caseInsensitive
            )
            
            if expression.firstMatch(in: value, options: [], range: NSRange(location: 0, length: value.count)) == nil {
                throw error
            }
        } catch {
            throw error
        }
        return value
    }
}
