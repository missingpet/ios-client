//
//  SignInPresenter.swift
//  MissingPet
//
//  Created by Михаил Еремеев on 20.11.2020.
//

import Foundation
import UIKit

class SignInPresenter: PresenterType {
    
    private let authReporitory: AuthorizationRepositoryType
    
    init(authRepository: AuthorizationRepositoryType) {
        self.authReporitory = authRepository
    }
    
    func signIn(email: String, password: String, controller: UIViewController) {
        
        guard let controller = controller as? SignInViewController else { return }
        
        let signInAlert = UIAlertController(title: "Успех", message: "Вы авторизованы в системе", preferredStyle: .alert)
        signInAlert.addAction(UIAlertAction(title: "Ок", style: .default, handler: nil))
        
        if email != "" && password != "" {
            authReporitory.signIn(email: email, password: password, completion: { [weak controller] (status) in
                if (status) {
                    controller?.present(signInAlert, animated: true, completion: nil)
                    
                } else {
                    let message = "Не удалось авторизоваться"
                    let title = "Ошибка"
                    signInAlert.title = title
                    signInAlert.message = message
                    controller?.present(signInAlert, animated: true, completion: nil)
                }
            })
        } else {
            let title = "Ошибка"
            let message = "Вы не ввели логин и/или пароль"
            signInAlert.title = title
            signInAlert.message = message
            controller.present(signInAlert, animated: true, completion: nil)
        }
    }
    
    func pushSignUpViewController() {
        Navigator(Storyboard.signUp).push(SignUpViewController.self, presenter: SignUpPresenter(authRepository: AuthorizationRepository()))
    }
    
}
