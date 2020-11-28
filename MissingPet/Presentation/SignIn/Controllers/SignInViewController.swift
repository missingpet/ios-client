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
        hideKeyboardOnTap()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.forceUpdateNavigationBar()
    }
    
    @IBAction func openSignUpViewController(_ sender: UIButton) {
        presenter?.openSignUpViewController()
    }
}

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
