//
//  SignUpPresenter.swift
//  MissingPet
//
//  Created by Михаил Еремеев on 28.11.2020.
//

import Foundation
import UIKit

class SignUpPresenter: PresenterType {

    var startLoadingSetter: UIUpdater?
    var stopLoadingSetter: UIUpdater?

    let authorizationRepository: AuthorizationRepositoryType!

    init(authorizationRepository: AuthorizationRepositoryType) {
        self.authorizationRepository = authorizationRepository
    }

    func startLoading() {
        self.startLoadingSetter?()
    }
    func stopLoading() {
        self.stopLoadingSetter?()
    }

    func singUp(_ controller: UIViewController,
                nickname: String,
                email: String,
                password: String,
                repeatedPassword: String) {

        if ConnectionService.isUnavailable {
            let alert = AlertService.getConnectionUnavalableAlert()
            controller.present(alert, animated: true, completion: nil)
            return
        }

        self.startLoading()

        guard !nickname.isEmpty,
              !email.isEmpty,
              !password.isEmpty,
              !repeatedPassword.isEmpty else {
            let alert = AlertService.getErrorAlert(message: "Пожалуйста, заполните все поля")
            self.stopLoading()
            controller.present(alert, animated: true, completion: nil)
            return
        }

        if password != repeatedPassword {
            let alert = AlertService.getErrorAlert(message: "Пароли не совпадают")
            self.stopLoading()
            controller.present(alert, animated: true, completion: nil)
        }

        if nickname.count < 3 {
            let alert = AlertService.getErrorAlert(message: "Никнейм должен содержать не менее чем 3 символа")
            self.stopLoading()
            controller.present(alert, animated: true, completion: nil)
            return
        }
        if nickname.count > 64 {
            let alert = AlertService.getErrorAlert(message: "Никнейм должен содержать не более чем 64 символа")
            self.stopLoading()
            controller.present(alert, animated: true, completion: nil)
            return
        }

        if password.count < 6 {
            let alert = AlertService.getErrorAlert(message: "Пароль должен содержать не менее чем 6 символов")
            self.stopLoading()
            controller.present(alert, animated: true, completion: nil)
            return
        }
        if password.count > 128 {
            let alert = AlertService.getErrorAlert(message: "Пароль должен содержать не более чем 128 символов")
            self.stopLoading()
            controller.present(alert, animated: true, completion: nil)
            return
        }

        authorizationRepository.register(nickname: nickname,
                                         email: email, password: password,
                                         onSuccess: { [weak self] in
                                            let alert = AlertService.getSuccessAlert(message: "Пользователь успешно зарегистрирован")
                                            controller.present(alert, animated: true, completion: nil)
                                            self?.stopLoading()
                                         },
                                         onFailure: { [weak self] message in
                                            self?.stopLoading()
                                            let alert = AlertService.getErrorAlert(message: message)
                                            controller.present(alert, animated: true,
                                                               completion: nil)
                                         })
    }

}
