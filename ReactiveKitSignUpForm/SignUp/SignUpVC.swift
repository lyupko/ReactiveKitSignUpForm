//
//  SignUpVC.swift
//  ReactiveKitSignUpForm
//
//  Created by Lyupko on 6/29/17.
//  Copyright © 2017 Lyupko. All rights reserved.
//

import UIKit

class SignUpVC: UIViewController {
    
    @IBOutlet var emailTF: UITextField!
    @IBOutlet var emailWarningLbl: UILabel!
    @IBOutlet var passwordTF: UITextField!
    @IBOutlet var passwordWarningLbl: UILabel!
    @IBOutlet var signUpBtn: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.emailTF.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)

        self.passwordTF.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
    }

    func textFieldDidChange(textField: UITextField) -> Bool {
        
        let emailAddressIsValid = SignUpVC.isValid(emailAddress: emailTF.text)
        let passwordIsValid = SignUpVC.isValid(password: passwordTF.text)
        

        switch textField {
        case emailTF:
            self.emailWarningLbl.isHidden = emailAddressIsValid
        case passwordTF:
            self.passwordWarningLbl.isHidden = passwordIsValid
        default: break
        }

        signUpBtn.isEnabled = emailAddressIsValid && passwordIsValid
        
        return true
    }
    
}

extension SignUpVC {
    
    @IBAction func signUpButtonPressed() {
        self.showAlert()
    }
    
    static func isValid(emailAddress: String?) -> Bool {
        guard let emailAddress = emailAddress else {
            return false
        }
        
        return NSPredicate(format: "SELF MATCHES %@", "\\A[^@]+@[^@]+\\z").evaluate(with: emailAddress)
    }
    
    static func isValid( password: String?) -> Bool {
        guard let password = password else {
            return false
        }
        
        return password.characters.count >= 8
    }
    
    func showAlert() {
        let alertController = UIAlertController(title: "Hello!",
                                                message: "You're all signed up.",
                                                preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK",
                                     style: .default,
                                     handler: nil)
        
        alertController.addAction(okAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
}
