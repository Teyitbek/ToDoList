public struct TextFieldValidationError: Error {
    var message: String
    init(_ message: String) {
        self.message = message
    }
}

enum TextFieldValidationErrorMessage {
    // keys
    static func message(for type: TextFieldType) -> String {
        switch type {
        case .password:
            return "Invalid password"
        case .validationCode:
            return "Invalid validation code"
        case .zipCode:
            return "Invalid zip code"
        case .amount(_, _, _, _):
            return "Invalid amount"
        case .email:
            return "Invalid email"
        case .custom(_):
            return "Invalid something"
        case .fullname:
            return "Invalid fullname"
        case .name:
            return "Invalid name"
        case .quantity:
            return "Invalid quantity"
        case .phoneNumber:
            return "Invalide phone number"
        case .number:
            return "Invalid number"
        }
    }
}
