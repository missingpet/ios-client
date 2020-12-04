//
//  SignInViewController.swift
//  MissingPet
//
//  Created by Михаил Еремеев on 20.11.2020.
//

import UIKit

class SignInViewController: Controller<SignInPresenter> {

    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextFieldDelegates()
        dismissKeyboardOnTap()
    }
    
    @IBAction func signIn(_ sender: UIButton) {
        presenter?.presentSignInAlert(viewController: self)
    }
    
    @IBAction func pushSignUpViewController(_ sender: UIButton) {
        presenter?.pushSignUpViewController()
    }
    
}

// MARK: - UITextFieldDelegate
extension SignInViewController: UITextFieldDelegate {
    
    private func setupTextFieldDelegates() {
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
