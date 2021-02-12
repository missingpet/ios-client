//
//  SignUpPresenter.swift
//  MissingPet
//
//  Created by Михаил Еремеев on 28.11.2020.
//

import Foundation
import UIKit

class SignUpPresenter: PresenterType {
    
    let authRepository: AuthorizationRepositoryType!
    
    init(authRepository: AuthorizationRepositoryType) {
        self.authRepository = authRepository
    }
    
    func singUp(username: String, email: String, password: String, repeatedPassword: String) {
        
    }
    
    func presentSignUpAlert(viewController: UIViewController) {
        let signUpAlert = UIAlertController(title: "Предупреждение", message: "Данный функционал пока что отсутсвует", preferredStyle: .alert)
        signUpAlert.addAction(UIAlertAction(title: "Хорошо", style: .default, handler: nil))
        viewController.present(signUpAlert, animated: true, completion: nil)
    }
    
}
