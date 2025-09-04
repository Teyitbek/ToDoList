import Foundation

struct PasswordValidator: TextFieldValidator {
    var error: TextFieldValidationError
    func validate(_ value: String) throws -> String {
        do {
            let expression = try NSRegularExpression(
                pattern: "^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#$%^&*.?]).{8,20}$"
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
