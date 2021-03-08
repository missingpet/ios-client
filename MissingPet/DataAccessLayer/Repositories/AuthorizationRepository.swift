//
//  AuthorizationRepository.swift
//  MissingPet
//
//  Created by Михаил Еремеев on 15.12.2020.
//

import Foundation
import Alamofire
import SwiftyJSON

class AuthorizationRepository: AuthorizationRepositoryType {

    // MARK: - UserDefaultsAccessor

    private let accessTokenStorage = UserDefaultsAccessor<String>(key: Constants.accessTokenKey)
    private let nicknameStorage = UserDefaultsAccessor<String>(key: Constants.nicknameKey)
    private let emailStorage = UserDefaultsAccessor<String>(key: Constants.emailKey)
    private let userIdStorage = UserDefaultsAccessor<Int>(key: Constants.userIdKey)

    // MARK: - API Requests

    func login(email: String,
               password: String,
               onSuccess: (() -> Void)?,
               onFailure: ((String) -> Void)?) {

        let parameters: [String: String] = [
            "email": email,
            "password": password
        ]

        AF.request(Router.login, method: .post, parameters: parameters)
            .validate(statusCode: 200..<300)
            .responseJSON(completionHandler: { (response) in
                switch response.result {
                case .success:
                    self.processLogin(data: response.data!)
                    onSuccess?()
                case .failure:
                    onFailure?(self.processLoginFailure(data: response.data!))
                }
            })
    }

    func register(nickname: String,
                  email: String,
                  password: String,
                  onSuccess: (() -> Void)?,
                  onFailure: ((String) -> Void)?) {

        let parameters: [String: String] = [
            "email": email,
            "nickname": nickname,
            "password": password
        ]

        AF.request(Router.register, method: .post, parameters: parameters)
            .validate(statusCode: 200..<300)
            .responseJSON(completionHandler: { (response) in
                switch response.result {
                case .success:
                    onSuccess?()
                case .failure:
                    onFailure?(self.processRegisterFailure(data: response.data!))
                }
            })
    }

    func logout() {
        self.processLogout()
    }

}

fileprivate extension AuthorizationRepository {

    // MARK: - Data Processing
    
    func processLogin(data: Data) {
        
        let json = JSON(data)
        
        guard let access = json["token"].string,
              let nickname = json["nickname"].string,
              let email = json["email"].string,
              let id = json["id"].int else { return }
        
        self.accessTokenStorage.value = access
        self.nicknameStorage.value = nickname
        self.emailStorage.value = email
        self.userIdStorage.value = id
    }

    func processLogout() {
        self.accessTokenStorage.value = nil
        self.userIdStorage.value = nil
        self.nicknameStorage.value = nil
        self.emailStorage.value = nil
    }
    
    func processLoginFailure(data: Data) -> String {
        let json = JSON(data)
        let detailMessage = json[Constants.detailKey].string!
        return detailMessage
    }
    
    func processRegisterFailure(data: Data) -> String {
        
        let json = JSON(data)
        
        let nonFieldErrorsErrorMessage = json[Constants.nonFieldErrorsErrorKey][0].string
        let emailErrorMessage = json[Constants.emailErrorMessageKey][0].string
        let nicknameErrorMessage = json[Constants.nicknameErrorMessageKey][0].string
        let passwordErrorMessage = json[Constants.passwordErrorMessageKey][0].string
        
        var resultMessage = ""
        
        let separator = "\n"
        
        if let nonFieldErrorsErrorMessage = nonFieldErrorsErrorMessage {
            resultMessage += nonFieldErrorsErrorMessage
        }
        if let emailErrorMessage = emailErrorMessage {
            resultMessage += emailErrorMessage
        }
        if let nicknameErrorMessage = nicknameErrorMessage {
            if emailErrorMessage != nil {
                resultMessage += separator
            }
            resultMessage += nicknameErrorMessage
        }
        if let passwordErrorMessage = passwordErrorMessage {
            if nicknameErrorMessage != nil {
                resultMessage += separator
            }
            resultMessage += passwordErrorMessage
        }
        
        return resultMessage
    }

}
