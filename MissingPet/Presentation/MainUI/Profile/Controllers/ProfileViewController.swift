//
//  ProfileViewController.swift
//  MissingPet
//
//  Created by Михаил Еремеев on 20.11.2020.
//

import UIKit

class ProfileViewController: Controller<ProfilePresenter>, UITextFieldDelegate {
    
    @IBOutlet weak var profileView: UIView!
    
    @IBOutlet weak var nicknameView: ProfileInfoView!
    @IBOutlet weak var emailView: ProfileInfoView!
    
    @IBOutlet weak var emailTextField: TextFieldWithImageView!
    @IBOutlet weak var passwordTextField: TextFieldWithImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard)))
        
        emailTextField.delegate = self
        emailTextField.keyboardType = .emailAddress
        emailTextField.textContentType = .emailAddress
        emailTextField.isSecureTextEntry = false
        
        passwordTextField.delegate = self
        passwordTextField.keyboardType = .asciiCapable
        passwordTextField.textContentType = .password
        passwordTextField.isSecureTextEntry = true
        
    }
    
    @IBAction func signIn(_ sender: UIButton) {
        dismissKeyboard()
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        presenter?.signIn(email: email, password: password, controller: self)
    }
    
    @IBAction func pushSignUpViewController(_ sender: UIButton) {
        dismissKeyboard()
        presenter?.pushSignUpViewController()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
}
