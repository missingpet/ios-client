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
    
    var loadingViewSetter: UISetter<Bool>?
    var largeActivityIndicatorSetter: UISetter<Bool>?
    
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
    
    func login(email: String?, password: String?) {
        if ConnectionService.isUnavailable { return }
        guard let email = email, let password = password else { return }
        authorizationReporitory.login(email: email,
                                      password: password,
                                      onSuccess: { (_) in
                                        self.setupUserInfoViews()
                                        self.postUserLoggedInOrLoggedOutNotification()
                                      },
                                      onFailure: nil)
    }
    
    func postUserLoggedInOrLoggedOutNotification() {
        notificationCenter.post(name: Notification.Name(Constants.userLoggedInOrLoggedOut),
                                     object: nil)
    }
    
    func postRefreshedAccessTokenNotification() {
        notificationCenter.post(name: Notification.Name(Constants.refreshedAccessToken),
                                object: nil)
    }
    
    func logout() {
        if ConnectionService.isUnavailable { return }
        authorizationReporitory.logout()
        postUserLoggedInOrLoggedOutNotification()
        setupUserInfoViews()
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
                                          presenter: SignUpPresenter(authRepository: AuthorizationRepository()))
    }
    
}
