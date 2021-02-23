//
//  SignUpPresenter.swift
//  MissingPet
//
//  Created by Михаил Еремеев on 28.11.2020.
//

import Foundation
import UIKit

class SignUpPresenter: PresenterType {

    let authorizationRepository: AuthorizationRepositoryType!

    init(authorizationRepository: AuthorizationRepositoryType) {
        self.authorizationRepository = authorizationRepository
    }

    func singUp(nickname: String, email: String, password: String, repeatedPassword: String) {
        authorizationRepository.register(nickname: nickname,
                                         email: email, password: password,
                                         onSuccess: nil,
                                         onFailure: nil)
    }

    func presentSignUpAlert(viewController: UIViewController) {
        let signUpAlert = UIAlertController(title: "Предупреждение", message: "Данный функционал пока что отсутсвует", preferredStyle: .alert)
        signUpAlert.addAction(UIAlertAction(title: "Хорошо", style: .default, handler: nil))
        viewController.present(signUpAlert, animated: true, completion: nil)
    }

}
