import Foundation

// swiftlint:disable discouraged_direct_init
struct NameValidator: TextFieldValidator {
    var error: TextFieldValidationError
    func validate(_ value: String) throws -> String {
        do {
            let expression = try NSRegularExpression(
                pattern: "[a-zA-Z]{1,1478}",
                options: .caseInsensitive
            )
            
            if expression.firstMatch(in: value, options: [], range: NSRange(location: 0, length: value.count)) == nil {
                throw NSError()
            }
        } catch {
            throw error
        }
        return value
    }
}
