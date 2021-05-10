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
    var stopLoadingSetter: UIUpdater?
    var startLoadingSetter: UIUpdater?

    private let authorizationReporitory: AuthorizationRepositoryType!
    private let userInfoRepository: UserInfoRepositoryType!

    private let notificationCenter = NotificationCenter.default

    init(authorizationReporitory: AuthorizationRepositoryType, userInfoRepository: UserInfoRepositoryType) {
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
            userInfoRepository.getUserEmail(onSuccess: { [weak self] email in
                                                self?.emailSetter?(email) },
                                            onFailure: nil)
            userInfoRepository.getUserNickname(onSuccess: { [weak self] nickname in
                                                self?.nicknameSetter?(nickname) },
                                               onFailure: nil)
        } else {
            profileViewSetter?(true)
        }
    }

    private func startAnimating() {
        startLoadingSetter?()
    }

    private func stopAnimatng() {
        stopLoadingSetter?()
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
                                      onSuccess: { [weak self] in
                                        self?.setupUserInfoViews()
                                        self?.postUserLoggedInNotification()
                                        self?.stopAnimatng()
                                      },
                                      onFailure: { [weak self] (message) in
                                        self?.stopAnimatng()
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
