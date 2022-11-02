//
//  ViewController.swift
//  ToDoList
//
//  Created by Tiku on 3/6/22.
//

import UIKit
import FirebaseAuth
import FlagPhoneNumber

class AuthViewController: UIViewController {
    
    @IBAction func closeSegue(_ sender: UIStoryboardSegue) {
        // for back to main page
    }
    
    var phoneNumber: String?
    
    // can search coutry
    var listController: FPNCountryListViewController!
    @IBOutlet weak var phoneNumberTextField: FPNTextField!
    @IBOutlet weak var fetchCodeButton: UIButton!
    @IBAction func fetchCodeTapped(_ sender: UIButton) {
        guard phoneNumber != nil else {return}
        PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber!, uiDelegate: nil) { (verificationID, error) in
            if error != nil {
                print(error?.localizedDescription ?? "Empty!")
            } else {
                self.showCodeValid(verificationID: verificationID ?? "Error number")
            }
        }
    }
    
    private func showCodeValid(verificationID: String) { // go to CodeValidVC
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let dvc = storyboard.instantiateViewController(withIdentifier: "CodeValidVC") as! CodeValidVC
        dvc .verificationID = verificationID
        self.present(dvc, animated: true, completion: nil)
    }
    
    @IBOutlet weak var invalidLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupConfig()
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(viewTapped)))
    }
   
    @objc func viewTapped() {
        phoneNumberTextField.resignFirstResponder()
    }
    
    private func setupConfig() {
        fetchCodeButton.alpha = 0
        fetchCodeButton.isEnabled = false
        
        phoneNumberTextField.displayMode = .list
        phoneNumberTextField.delegate = self
        
        listController = FPNCountryListViewController(style: .grouped)
        listController?.setup(repository: phoneNumberTextField.countryRepository)
        listController.didSelect = { country in
            self.phoneNumberTextField.setFlag(countryCode: country.code)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
}

extension AuthViewController: FPNTextFieldDelegate {
    // what will happened after tapped country
    func fpnDidSelectCountry(name: String, dialCode: String, code: String) {
        //
    }
    // button active or not
    func fpnDidValidatePhoneNumber(textField: FPNTextField, isValid: Bool) {
        if isValid {
            fetchCodeButton.alpha = 1
            fetchCodeButton.isEnabled = true
            invalidLabel.text = ""
            phoneNumber = textField.getFormattedPhoneNumber(format: .International)
            
        } else {
            fetchCodeButton.alpha = 0.5
            fetchCodeButton.isEnabled = false
            invalidLabel.text = "Invalid input"
        }
    }
    // show listController
    func fpnDisplayCountryList() {
        let navigationController = UINavigationController(rootViewController: listController)
        listController.title = "Countries"
        phoneNumberTextField.text = ""
        self.present(navigationController, animated: true)
    }
    
    
}

// try delete remote branch 
