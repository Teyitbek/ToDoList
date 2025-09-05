import UIKit
import Constants

@MainActor
protocol PincodeViewDelegate: AnyObject {
    func onPinEntered(_ pin: String)
}

class PincodeView: UIView {
    private var pinDigits: [UILabel] = []
    private var enteredDigits: [String] = []

    weak var delegate: PincodeViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupPincodeBoxes()
        setupKeypad()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupPincodeBoxes() {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        stackView.spacing = 20

        for _ in 0..<4 {
            let label = UILabel()
            label.text = "–"
            label.textColor = .EBEDF_5
            label.font = .systemFont(ofSize: 24, weight: .semibold)
            label.textAlignment = .center
            label.layer.borderWidth = 1
            label.layer.cornerRadius = 8
            label.layer.borderColor = UIColor.CED_0_DB.cgColor
            label.clipsToBounds = true
            
            label.anchor(
                .height(Constants.UI.padding64)
            )
            
            pinDigits.append(label)
            stackView.addArrangedSubview(label)
        }

        addSubview(stackView)
        stackView.anchor(
            .top(topAnchor),
            .leading(leadingAnchor),
            .trailing(trailingAnchor),
            .centerX(centerXAnchor)
        )
    }

    private func setupKeypad() {
        let keypadStackView = UIStackView()
        keypadStackView.axis = .vertical
        keypadStackView.spacing = Constants.UI.padding12
        addSubview(keypadStackView)

        let buttonTitles = [
            ["1", "2", "3"],
            ["4", "5", "6"],
            ["7", "8", "9"],
            ["", "0", "⌫"]
        ]

        for row in buttonTitles {
            let rowStack = UIStackView()
            rowStack.axis = .horizontal
            rowStack.spacing = Constants.UI.padding42
            rowStack.distribution = .fillEqually

            for title in row {
                let button = UIButton(type: .system)
                button.setTitle(title, for: .normal)
                button.setTitleColor(.black, for: .normal)
                button.titleLabel?.font = .systemFont(ofSize: Constants.UI.padding26, weight: .regular)
                button.backgroundColor = title.isEmpty ? .clear : .EBEDF_5
                button.layer.cornerRadius = Constants.UI.padding40
                button.addTarget(self, action: #selector(keypadButtonTapped(_:)), for: .touchUpInside)
                button.anchor(
                    .height(Constants.UI.padding80),
                    .width(Constants.UI.padding80)
                )
                rowStack.addArrangedSubview(button)
            }
            keypadStackView.addArrangedSubview(rowStack)
        }
        
        keypadStackView.anchor(
            .top(pinDigits[0].superview!.bottomAnchor, constant: Constants.UI.padding24),
            .leading(leadingAnchor),
            .trailing(trailingAnchor),
            .bottom(bottomAnchor)
        )
    }

    @objc private func keypadButtonTapped(_ sender: UIButton) {
        guard let title = sender.currentTitle else { return }

        if title == "⌫" {
            if !enteredDigits.isEmpty {
                enteredDigits.removeLast()
                setupPinDigitLabelAsEmpty(label: pinDigits[enteredDigits.count])
                
            }
        } else if title != "" && enteredDigits.count < 4 {
            enteredDigits.append(title)
            setupPinDigitLabelAsFilled(label: pinDigits[enteredDigits.count - 1])
        }

        if enteredDigits.count == 4 {
            let pin = enteredDigits.joined()
            delegate?.onPinEntered(pin)
        }
    }

    func reset() {
        enteredDigits.removeAll()
        for label in pinDigits {
            setupPinDigitLabelAsEmpty(label: label)
        }
    }
    
    private func setupPinDigitLabelAsFilled(label: UILabel) {
        label.text = "•"
        label.font = .systemFont(ofSize: 50, weight: .semibold)
        label.textColor = .black
    }
    
    private func setupPinDigitLabelAsEmpty(label: UILabel) {
        label.text = "–"
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        label.textColor = .EBEDF_5
    }
}
