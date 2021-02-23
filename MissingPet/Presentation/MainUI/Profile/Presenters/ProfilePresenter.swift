//
//  ProfilePresenter.swift
//  MissingPet
//
//  Created by Михаил Еремеев on 20.11.2020.
//

import Foundation

class ProfilePresenter: PresenterType {

    var nicknameSetter: UISetter<String>?
    var emailSetter: UISetter<String>?
    var profileViewSetter: UISetter<Bool>?
    var loadingSetter: UISetter<Bool>?

    private let authorizationReporitory: AuthorizationRepositoryType!

    private let notificationCenter = NotificationCenter.default

    init(authorizationReporitory: AuthorizationRepositoryType) {
        self.authorizationReporitory = authorizationReporitory
    }

    func setup() {
        setupUserInfoViews()
    }

    private func setupUserInfoViews() {
        profileViewSetter?(AppSettings.isAuthorized)
        emailSetter?(AppSettings.currentUserEmail ?? "")
        nicknameSetter?(AppSettings.currentUserNickname ?? "")
    }

    private func startAnimating() {
        loadingSetter?(true)
    }

    private func stopAnimatng() {
        loadingSetter?(false)
    }

    func login(email: String?, password: String?) {
        if ConnectionService.isUnavailable { return }
        guard let email = email, let password = password else { return }

        startAnimating()

        authorizationReporitory.login(email: email,
                                      password: password,
                                      onSuccess: { (_) in
                                        self.setupUserInfoViews()
                                        self.postUserLoggedInNotification()
                                        self.stopAnimatng()
                                      },
                                      onFailure: { (_) in
                                        self.stopAnimatng()
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

    func postRefreshedAccessTokenNotification() {
        notificationCenter.post(name: Notification.Name(Constants.refreshedAccessToken),
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

    func refreshAccessToken() {
        if ConnectionService.isUnavailable { return }
        authorizationReporitory.refreshAccessToken(onSuccess: { (_) in
            self.postRefreshedAccessTokenNotification()
        },
        onFailure: nil)
    }

    func pushSignUpViewController() {
        Navigator(Storyboard.signUp).push(SignUpViewController.self,
                                          presenter: SignUpPresenter(authorizationRepository: AuthorizationRepository()))
    }

}
