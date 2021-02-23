//
//  SignUpViewController.swift
//  MissingPet
//
//  Created by Михаил Еремеев on 28.11.2020.
//

import UIKit

class SignUpViewController: Controller<SignUpPresenter>, UITextFieldDelegate {

    @IBOutlet weak var nicknameTextField: TextFieldWithImageView!
    @IBOutlet weak var emailTextField: TextFieldWithImageView!
    @IBOutlet weak var passwordTextField: TextFieldWithImageView!
    @IBOutlet weak var repeatPasswordTextField: TextFieldWithImageView!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()

        nicknameTextField.delegate = self
        nicknameTextField.keyboardType = .asciiCapable
        nicknameTextField.textContentType = .username
        nicknameTextField.isSecureTextEntry = false

        emailTextField.delegate = self
        emailTextField.keyboardType = .emailAddress
        emailTextField.textContentType = .emailAddress
        emailTextField.isSecureTextEntry = false

        passwordTextField.delegate = self
        passwordTextField.keyboardType = .asciiCapable
        passwordTextField.textContentType = .password
        passwordTextField.isSecureTextEntry = true

        repeatPasswordTextField.delegate = self
        repeatPasswordTextField.keyboardType = .asciiCapable
        repeatPasswordTextField.textContentType = .password
        repeatPasswordTextField.isSecureTextEntry = true

        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard)))

    }

    @IBAction func signUp(_ sender: UIButton) {
        let nickname = nicknameTextField.text ?? ""
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        let repeatedPassword = repeatPasswordTextField.text ?? ""
        presenter?.singUp(nickname: nickname,
                          email: email,
                          password: password,
                          repeatedPassword: repeatedPassword)
    }

    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}
