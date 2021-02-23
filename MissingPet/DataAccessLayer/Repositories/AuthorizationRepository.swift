//
//  AuthorizationRepository.swift
//  MissingPet
//
//  Created by Михаил Еремеев on 15.12.2020.
//

import Foundation
import Alamofire

class AuthorizationRepository: AuthorizationRepositoryType {

    // MARK: - UserDefaultsAccessor

    private let refreshTokenStorage = UserDefaultsAccessor<String>(key: Constants.refreshTokenKey)
    private let accessTokenStorage = UserDefaultsAccessor<String>(key: Constants.accessTokenKey)
    private let nicknameStorage = UserDefaultsAccessor<String>(key: Constants.nicknameKey)
    private let emailStorage = UserDefaultsAccessor<String>(key: Constants.emailKey)
    private let userIdStorage = UserDefaultsAccessor<Int>(key: Constants.userIdKey)

    // MARK: - API Requests

    func login(email: String,
               password: String,
               onSuccess: ((LoginResult) -> Void)?,
               onFailure: ((String) -> Void)?) {

        let parameters: [String: String] = [
            "email": email,
            "password": password
        ]

        AF.request(Router.login, method: .post, parameters: parameters)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: LoginResult.self, completionHandler: { (response) in
                switch response.result {
                case .success(let value):
                    self.processLogin(loginResult: value)
                    onSuccess?(value)
                case .failure(let error):
                    onFailure?(error.localizedDescription)
                }
            })
    }

    func register(nickname: String,
                  email: String,
                  password: String,
                  onSuccess: ((RegisterResult) -> Void)?,
                  onFailure: ((String) -> Void)?) {

        let parameters: [String: String] = [
            "email": email,
            "nickname": nickname,
            "password": password
        ]

        AF.request(Router.register, method: .post, parameters: parameters)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: RegisterResult.self, completionHandler: { (response) in
                switch response.result {
                case .success(let value):
                    onSuccess?(value)
                case .failure(let error):
                    onFailure?(error.localizedDescription)
                }
            })
    }

    func refreshAccessToken(onSuccess: ((TokenRefreshResult) -> Void)?,
                            onFailure: ((String) -> Void)?) {

        let refreshToken = refreshTokenStorage.value!

        let parameters: [String: String] = [
            "refresh": refreshToken
        ]

        AF.request(Router.tokenRefresh, method: .post, parameters: parameters)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: TokenRefreshResult.self, completionHandler: { (response) in
                switch response.result {
                case .success(let value):
                    self.processTokenRefresh(tokenRefreshResult: value)
                    onSuccess?(value)
                case .failure(let error):
                    onFailure?(error.localizedDescription)
                }
            })
    }

    func logout() {
        self.processLogout()
    }

}

fileprivate extension AuthorizationRepository {

    // MARK: - Data Processing

    func processLogin(loginResult: LoginResult) {
        accessTokenStorage.value = loginResult.access
        refreshTokenStorage.value = loginResult.refresh
        nicknameStorage.value = loginResult.nickname
        emailStorage.value = loginResult.email
        userIdStorage.value = loginResult.id
    }

    func processTokenRefresh(tokenRefreshResult: TokenRefreshResult) {
        accessTokenStorage.value = tokenRefreshResult.access
    }

    func processLogout() {
        accessTokenStorage.value = nil
        refreshTokenStorage.value = nil
        userIdStorage.value = nil
        nicknameStorage.value = nil
        emailStorage.value = nil
    }

}
