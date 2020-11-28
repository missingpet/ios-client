//
//  SignUpViewController.swift
//  MissingPet
//
//  Created by Михаил Еремеев on 28.11.2020.
//

import UIKit

class SignUpViewController: Controller<SignUpPresenter> {

    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var repeatPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextFieldDelegates()
        hideKeyboardOnTap()
    }

}

extension SignUpViewController: UITextFieldDelegate {
    
    private func setupTextFieldDelegates() {
        usernameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        repeatPasswordTextField.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
