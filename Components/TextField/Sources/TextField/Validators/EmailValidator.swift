import Foundation

struct EmailValidator: TextFieldValidator {
    var error: TextFieldValidationError
    func validate(_ value: String) throws -> String {
        do {
            let expression = try NSRegularExpression(
                pattern: "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}$",
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
