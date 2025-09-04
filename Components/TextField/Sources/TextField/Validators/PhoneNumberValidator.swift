import Foundation

// swiftlint:disable line_length
struct PhoneNumberValidator: TextFieldValidator {
    var error: TextFieldValidationError
    func validate(_ value: String) throws -> String {
        let regex = "\\+(9([976])\\d|8[987530]\\d|6[987]\\d|5[90]\\d|42\\d|3[875]\\d|2[98654321]\\d|9[8543210]|8[6421]|6[6543210]|5[87654321]|4[987654310]|3[9643210]|2[70]|7|1)\\d{1,14}$"
        do {
            let expression = try NSRegularExpression(
                pattern: regex,
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
