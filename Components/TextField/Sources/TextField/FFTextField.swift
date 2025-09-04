import UIKit

// swiftlint:disable all
public class FFTextField: UITextField {
    private var padding: UIEdgeInsets = .init()
    
    // UI elements
    public lazy var leadingButton = makeLeadingButton()
    public lazy var trailingButton = makeTrailingButton()
    private(set) var pickerView: UIPickerView!
    private(set) var datePickerView: UIDatePicker!
    
    // Properties
    public var isRequired = false
    private var clearButtonTapped = false
    public var isSelectionDisabled = false
    private var maskType: MaskedInputType?
    private var clearButtonEdgeInsets = UIEdgeInsets(top: 0, left: -8, bottom: 0, right: 8)
    private var validator: TextFieldValidator?
    
    public var textfieldState: TextfieldState = .default {
        didSet {
            layer.borderColor = textfieldState.borderColor.cgColor
        }
    }
    
    public var nextTextfield: UIResponder? = nil {
        didSet {
            returnKeyType = nextTextfield == nil ? .done : .next
        }
    }
    
    public var isValid: Bool {
        let textIsEmpty = text?.isEmpty ?? false
        let requiredCondition = isRequired ? !textIsEmpty : true
        let condition = requiredCondition && textfieldState != .error
        textfieldState = condition ? .success : .error
        return condition
    }
    
    /// rawText is used for child classes which have this particular functionality with formatting and avoiding type casting
    public var rawText: String {
        guard let text = text else { return "" }
        return text
    }
    
    /// formattedText is used for child classes which have this particular functionality with formatting and avoiding type casting
    public var formattedText: String {
        return rawText
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    public init(placeholder: String = "", padding: UIEdgeInsets = .init(top: 0, left: 8, bottom: 0, right: 8), nextTextfield: UIResponder? = nil) {
        self.padding = padding
        self.nextTextfield = nextTextfield
        super.init(frame: .zero)
        self.trailingButton.isHidden = true
        self.autocorrectionType = .no
        self.delegate = self
        self.font = .preferredFont(forTextStyle: .body)
        self.textColor = .black
        self.contentVerticalAlignment = .center
        self.backgroundColor = .clear
        self.contentMode = contentMode
        self.layer.cornerRadius = 12
        self.layer.borderColor = textfieldState.borderColor.cgColor
        self.layer.borderWidth = 1
        self.autocapitalizationType = .sentences
        let placeholderAttributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.systemGray,
                                                                    .font: UIFont.preferredFont(forTextStyle: .body)]
        self.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: placeholderAttributes)
        returnKeyType = nextTextfield == nil ? .done : .next
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        bringSubviewToFront(trailingButton)
        bringSubviewToFront(leadingButton)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        padding = .zero
        super.init(coder: aDecoder)
    }
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    @discardableResult
    override open func becomeFirstResponder() -> Bool {
        if clearButtonTapped {
            clearButtonTapped = false
            return false
        }
        let success = super.becomeFirstResponder()
        if isSecureTextEntry, let text = self.text {
            self.text?.removeAll()
            insertText(text)
        }
        return success
    }
    
    override open var isSecureTextEntry: Bool {
        didSet {
            if isFirstResponder {
                _ = becomeFirstResponder()
            }
        }
    }
    
    open func setPadding(_ padding: UIEdgeInsets) {
        self.padding = padding
    }
    
    open func getPadding() -> UIEdgeInsets {
        return self.padding
    }
    
    override open func caretRect(for position: UITextPosition) -> CGRect {
        return isSelectionDisabled ? .zero : super.caretRect(for: position)
    }
    
    override open func selectionRects(for range: UITextRange) -> [UITextSelectionRect] {
        return isSelectionDisabled ? [] : super.selectionRects(for: range)
    }
    
    override open func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        return isSelectionDisabled ? false : super.canPerformAction(action, withSender: sender)
    }
    
    open override func clearButtonRect(forBounds bounds: CGRect) -> CGRect {
        let bounds = super.clearButtonRect(forBounds: bounds)
        return bounds.inset(by: clearButtonEdgeInsets)
    }
}

extension FFTextField: UITextFieldDelegate {
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        textfieldState = .focused
    }
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
        guard textfieldState == .focused else { return }
        textfieldState = .default
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let nextTextfield = nextTextfield {
            nextTextfield.becomeFirstResponder()
        } else {
            resignFirstResponder()
        }
        return true
    }
    
    public func textFieldShouldClear(_ textField: UITextField) -> Bool {
        clearButtonTapped = true
        return true
    }
}

extension FFTextField {
    private func withValidation(_ type: TextFieldType) {
        validator = TextFieldVaildatorFactory.validator(for: type)
        addTarget(self, action: #selector(validate(sender:)), for: .editingChanged)
    }
    
    func setValidator(message: String) {
        validator?.error.message = message
    }
    
    func validate(onSuccess: (() -> Void)? = nil) {
        guard isValid else {
            showInvalidFieldPresentation()
            return
        }
        onSuccess?()
    }
    
    func showInvalidFieldPresentation() {
        shake()
        textfieldState = .error
    }
}

extension FFTextField {
    func withKeyboard(for type: TextFieldType) {
        switch type {
        case .validationCode, .quantity, .zipCode, .number:
            keyboardType = .numberPad
        case .email:
            keyboardType = .emailAddress
            autocapitalizationType = .none
        case .amount:
            keyboardType = .decimalPad
        case .name:
            keyboardType = .alphabet
        case .password:
            autocapitalizationType = .none
        default:
            break
        }
    }
}

extension FFTextField {
    func withFormatting(_ type: TextFieldType) {
        switch type {
        case .validationCode, .quantity, .zipCode, .number:
            break
        case .amount:
            break
        case .name:
            break
        default:
            break
        }
    }
}

public extension FFTextField {
    @discardableResult
    func with(textFieldType: TextFieldType, formatting: Bool = false, validation: Bool = false) -> FFTextField {
        withKeyboard(for: textFieldType)
        
        if formatting {
            withFormatting(textFieldType)
        }
        if validation {
            withValidation(textFieldType)
        }
        withTrailingButtonAction(type: textFieldType)
        return self
    }
}

public extension FFTextField {
    func withTrailingButtonAction(type: TextFieldType) {
        switch type {
        case .password:
            trailingButton.addTarget(self, action: #selector(passwordTrailingButtonAction), for: .touchUpInside)
        default:
            break
        }
    }
    
    func withTrailingIcon(image: UIImage, trailingConstant: CGFloat = 8, isUserInteractionEnabled: Bool = true) {
        addSubview(trailingButton)
        trailingButton.isUserInteractionEnabled = isUserInteractionEnabled
        trailingButton.translatesAutoresizingMaskIntoConstraints = false
        trailingButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: trailingConstant).isActive = true
        trailingButton.topAnchor.constraint(equalTo: topAnchor).isActive = true
        trailingButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        trailingButton.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        trailingButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        padding.right += 8
        clearButtonEdgeInsets.right += padding.right / 2
        clearButtonEdgeInsets.left -= padding.right / 2
        trailingButton.setImage(image, for: .normal)
        trailingButton.isHidden = false
    }
    
    @discardableResult
    func withLeading(image: UIImage, leadingConstant: CGFloat = 8, isUserInteractionEnabled: Bool = true, isHidden: Bool = false) -> FFTextField {
        let imageSize = CGSize(width: 20, height: 20)
        addSubview(leadingButton)
        leadingButton.isUserInteractionEnabled = isUserInteractionEnabled
        leadingButton.translatesAutoresizingMaskIntoConstraints = false
        leadingButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: leadingConstant).isActive = true
        leadingButton.widthAnchor.constraint(equalToConstant: imageSize.width).isActive = true
        leadingButton.heightAnchor.constraint(equalToConstant: imageSize.height).isActive = true
        leadingButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        padding.left += leadingConstant * 2
        leadingButton.setImage(image, for: .normal)
        leadingButton.isHidden = isHidden
        return self
    }
}

public extension FFTextField {
    @discardableResult
    func with(pickerView: UIPickerView) -> Self {
        self.pickerView = pickerView
        inputView = pickerView
        isSelectionDisabled = true
        tintColor = .clear
        return self
    }
    
    @discardableResult
    func with(datePicker: UIDatePicker) -> Self {
        self.datePickerView = datePicker
        inputView = datePickerView
        inputAccessoryView = nil
        isSelectionDisabled = true
        tintColor = .clear
        return self
    }
}

// MARK: Actions
private extension FFTextField {
    @objc func applyMask(_ sender: UITextField) {
        guard let maskType = maskType else { return }
        guard let text = sender.text else { return }
        let formattedText = InputFormatter.formatStringToMask(
            text: text,
            format: maskType.mask,
            minNumber: maskType.minLength,
            max: maskType.maxLength
        )
        
        self.text = formattedText.uppercased()
    }
    
    @objc func validate(sender: UITextField) {
        guard let text = sender.text,
              let validator = validator else { return }
        do {
            _ = try validator.validate(text)
            textfieldState = .success
        } catch {
            textfieldState = .error
        }
    }
    
    @objc func passwordTrailingButtonAction() {
        self.isSecureTextEntry.toggle()
        self.trailingButton.setImage(self.isSecureTextEntry ? .eyeClosed:.eye , for: .normal)
    }
}

// MARK: - UI factory methods
private extension FFTextField {
    func makeTrailingButton() -> UIButton {
        let button = UIButton()
        button.isHidden = true
        return button
    }
    
    func makeLeadingButton() -> UIButton {
        let button = UIButton()
        button.isHidden = true
        return button
    }
}
