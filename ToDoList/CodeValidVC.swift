//
//  CodeValidVC.swift
//  ToDoList
//
//  Created by Tiku on 3/6/22.
//

import UIKit
import FirebaseAuth


class CodeValidVC: UIViewController {
    
    var verificationID: String!
    
    @IBOutlet weak var codeTextField: UITextField!
    @IBOutlet weak var checkCodebutton: UIButton!
    
    @IBAction func checkCodeTapped(_ sender: UIButton) {
        guard let code = codeTextField.text else {return}
        let credential = PhoneAuthProvider.provider().credential(
            withVerificationID: verificationID, verificationCode: code)
        Auth.auth().signIn(with: credential) { (_, error) in
            if error != nil {
                self.invalidLabel.text = "Invalid input"
            } else {
                self.showContentVC()
            }
        }
    }
    
    func showContentVC() {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let contentVC = mainStoryboard.instantiateViewController(withIdentifier: "ContentVC") as! ContentVC
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = contentVC
    }
    
    @IBOutlet weak var sendCodeLabel: UILabel!
    @IBOutlet weak var invalidLabel: UILabel!
    @IBOutlet weak var didNotGetCode: UILabel!
    @IBOutlet weak var timerAnimation: UILabel!
    var counter = 30
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sendCodeLabel.text = "We've sent code: "
        setupConfig()
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(viewTapped)))
        createTimer()
        didNotGetCode.text = "Didn't get code?"
    }
    func createTimer() {
        Timer.scheduledTimer(timeInterval: 1.0,
                                           target: self,
                                           selector: #selector(timerSelector),
                                           userInfo: nil,
                                           repeats: true)
    }
    
    @objc func viewTapped() {
        codeTextField.resignFirstResponder()
    }
    
    @objc func timerSelector() {
        if counter > 0 {
            timerAnimation.text = "Resend code in \(counter)sec"
            counter -= 1
            if counter == 0 {
                timerAnimation.text = "Finish!"
            }
        }
    }
    
    private func setupConfig() {
        checkCodebutton.alpha = 0.5
        checkCodebutton.isEnabled = false
        codeTextField.delegate = self
    }
 
}

extension CodeValidVC: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentCharCount = textField.text?.count ?? 0
        if range.length + range.location > currentCharCount {
            return false
        }
        
        checkCodebutton.alpha = 1
        checkCodebutton.isEnabled = true
        let newLength = currentCharCount + string.count - range.length
        return newLength <= 6
        
    }

    
}
