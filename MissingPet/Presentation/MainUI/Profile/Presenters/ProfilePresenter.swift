//
//  ProfilePresenter.swift
//  MissingPet
//
//  Created by Михаил Еремеев on 20.11.2020.
//

import UIKit
import Foundation

class ProfilePresenter: PresenterType {

    var nicknameSetter: UISetter<String>?
    var emailSetter: UISetter<String>?
    var profileViewSetter: UISetter<Bool>?
    var loadingSetter: UISetter<Bool>?

    private let authorizationReporitory: AuthorizationRepositoryType!
    private let userInfoRepository: UserInfoRepositoryType!

    private let notificationCenter = NotificationCenter.default

    init(authorizationReporitory: AuthorizationRepositoryType,
         userInfoRepository: UserInfoRepositoryType) {
        self.authorizationReporitory = authorizationReporitory
        self.userInfoRepository = userInfoRepository
    }

    func setup() {
        setupUserInfoViews()
    }

    func presentLogoutConfirmationAlert(controller: UIViewController) {
        let alert = UIAlertController(title: "Предупреждение",
                                      message: "Данные для входа будут удалены. Вы действительно хотите выйти из профиля?",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Да",
                                      style: .destructive,
                                      handler: { (_) in self.logout() }))
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
        controller.present(alert, animated: true, completion: nil)
    }

    func setupUserInfoViews() {
        if AppSettings.isAuthorized {
            profileViewSetter?(false)
            userInfoRepository.getUserEmail(onSuccess: { email in self.emailSetter?(email) },
                                            onFailure: nil)
            userInfoRepository.getUserNickname(onSuccess: { nickname in self.nicknameSetter?(nickname) },
                                               onFailure: nil)
        } else {
            profileViewSetter?(true)
        }
    }

    private func startAnimating() {
        loadingSetter?(true)
    }

    private func stopAnimatng() {
        loadingSetter?(false)
    }

    func login(_ controller: UIViewController, email: String, password: String) {
        if ConnectionService.isUnavailable {
            let alert = AlertService.getConnectionUnavalableAlert()
            controller.present(alert, animated: true, completion: nil)
            return
        }
        guard !email.isEmpty, !password.isEmpty else {
            let alert = AlertService.getErrorAlert(message: "Пожалуйста, заполните все поля")
            controller.present(alert, animated: true, completion: nil)
            return
        }

        startAnimating()

        authorizationReporitory.login(email: email,
                                      password: password,
                                      onSuccess: {
                                        self.setupUserInfoViews()
                                        self.postUserLoggedInNotification()
                                        self.stopAnimatng()
                                      },
                                      onFailure: { (message) in
                                        self.stopAnimatng()
                                        let alert = AlertService.getErrorAlert(message: message)
                                        controller.present(alert, animated: true, completion: nil)
                                      })
    }

    private func postUserLoggedInNotification() {
        notificationCenter.post(name: Notification.Name(Constants.userLoggedIn),
                                     object: nil)
    }

    private func postUserLoggedOutNotification() {
        notificationCenter.post(name: Notification.Name(Constants.userLoggedOut),
                                     object: nil)
    }

    func logout() {
        if ConnectionService.isUnavailable { return }
        startAnimating()
        authorizationReporitory.logout()
        postUserLoggedOutNotification()
        setupUserInfoViews()
        stopAnimatng()
    }

    func pushSignUpViewController() {
        Navigator(Storyboard.signUp).push(SignUpViewController.self,
                                          presenter: SignUpPresenter(authorizationRepository: AuthorizationRepository()))
    }

}
