public enum TextFieldVaildatorFactory {
    public static func validator(for type: TextFieldType, message: String = "") -> TextFieldValidator {
        switch type {
        case .fullname:
            return FullnameValidator(error: .init(message))
        case .quantity:
            return QuantityValidator(error: .init(message))
        case .email:
            return EmailValidator(error: .init(message))
        case .name:
            return NameValidator(error: .init(message))
        case .password:
            return PasswordValidator(error: .init(message))
        case .validationCode:
            return ValidationCodeValidator(error: .init(message))
        case .zipCode:
            return ZipCodeValidator(error: .init(message))
        case .amount(let min, let max, let minText, let maxText):
            return AmountValidator(error: .init(message), minAmount: min, maxAmount: max, minAmountInvalidText: minText, maxAmountInvalidText: maxText)
        case .custom(let regex):
            return CustomValidator(regex: regex, error: .init(message))
        case .phoneNumber:
            return PhoneNumberValidator(error: .init(message))
        case .number:
            return NumberValidator(error: .init(message))
        }
    }
}
