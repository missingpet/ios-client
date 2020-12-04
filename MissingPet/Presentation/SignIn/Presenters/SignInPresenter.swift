//
//  SignInPresenter.swift
//  MissingPet
//
//  Created by Михаил Еремеев on 20.11.2020.
//

import Foundation
import UIKit

class SignInPresenter: DefaultPresenterType {
    
    required init() {}
    
    func presentSignInAlert(viewController: UIViewController) {
        let signInAlert = UIAlertController(title: "Предупреждение", message: "Данный функционал пока что отсутсвует", preferredStyle: .alert)
        signInAlert.addAction(UIAlertAction(title: "Хорошо", style: .default, handler: nil))
        viewController.present(signInAlert, animated: true, completion: nil)
    }
    
    func pushSignUpViewController() {
        Navigator(Storyboard.signUp).push(SignUpViewController.self, presenter: SignUpPresenter())
    }
    
}
