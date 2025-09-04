import Foundation

struct FullnameValidator: TextFieldValidator {
    var error: TextFieldValidationError
    func validate(_ value: String) throws -> String {
        do {
            let expression = try NSRegularExpression(
                pattern: "/^.{6,}$/",
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
