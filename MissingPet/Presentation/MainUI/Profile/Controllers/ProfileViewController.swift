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
    
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var largeActivityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        presenter?.profileViewSetter = { [weak self] isAuthorized in
            self?.profileView.isHidden = !isAuthorized
        }
        presenter?.emailSetter = { [weak self] email in
            self?.emailView.text = email
        }
        presenter?.nicknameSetter = { [weak self] nickname in
            self?.nicknameView.text = nickname
        }
        presenter?.loadingViewSetter = { [weak self] isHidden in
            self?.loadingView.isHidden = isHidden
        }
        presenter?.largeActivityIndicatorSetter = { [weak self] isAnimating in
            if isAnimating {
                self?.largeActivityIndicator.startAnimating()
            } else {
                self?.largeActivityIndicator.stopAnimating()
            }
        }
        
        super.viewDidLoad()
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                         action: #selector(dismissKeyboard)))
        
        emailTextField.delegate = self
        emailTextField.keyboardType = .emailAddress
        emailTextField.textContentType = .emailAddress
        emailTextField.isSecureTextEntry = false
        
        passwordTextField.delegate = self
        passwordTextField.keyboardType = .asciiCapable
        passwordTextField.textContentType = .password
        passwordTextField.isSecureTextEntry = true
    }
    
    @IBAction func login(_ sender: UIButton) {
        dismissKeyboard()
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        presenter?.login(email: email, password: password)
    }
    
    @IBAction func logout(_ sender: UIButton) {
        dismissKeyboard()
        presenter?.logout()
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
