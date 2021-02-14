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
               completion: @escaping (Bool) -> Void) {
        
        let parameters: [String: String] = [
            "email": email,
            "password": password
        ]
        
        AF.request(Router.login, method: .post, parameters: parameters).response(completionHandler: { response in
            let statusCode = response.response?.statusCode
            if statusCode == 200 {
                let data = response.data!
                self.processLogin(data: data)
                completion(true)
            } else {
                completion(false)
            }
        })
    }
    
    func register(nickname: String,
                  email: String,
                  password: String,
                  completion: @escaping (Bool) -> Void) {
        
        let parameters: [String: String] = [
            "email": email,
            "nickname": nickname,
            "password": password
        ]
        
        AF.request(Router.register, method: .post, parameters: parameters).response(completionHandler: { (dataResponse) in
            let statusCode = dataResponse.response?.statusCode
            if statusCode == 201 {
                completion(true)
            } else {
                completion(false)
            }
        })
        
    }
    
    func refreshAccessToken(completion: @escaping (Bool) -> Void) {
        
        let refreshToken = refreshTokenStorage.value!
        
        let parameters: [String: String] = [
            "refresh": refreshToken
        ]
        
        AF.request(Router.tokenRefresh, method: .post, parameters: parameters).response(completionHandler: { response in
            let statusCode = response.response?.statusCode
            if statusCode == 200 {
                let data = response.data!
                self.processRefreshAccessToken(data: data)
                completion(true)
            } else {
                completion(false)
            }
        })
        
    }
    
    
    func logout(completion: @escaping () -> Void) {
        self.processLogout()
        completion()
    }
    
}

fileprivate extension AuthorizationRepository {
    
    struct UserInfo: Decodable {
        
        let refresh: String
        let access: String
        let id: Int
        let email: String
        let nickname: String
        
    }
    
    struct AccessToken: Decodable {
        let access: String
    }
    
    // MARK: - Data Processing
    
    func processLogin(data: Data) {
        
        let decoder = JSONDecoder()
        let userInfo = try! decoder.decode(UserInfo.self, from: data)
        
        accessTokenStorage.value = userInfo.access
        refreshTokenStorage.value = userInfo.refresh
        nicknameStorage.value = userInfo.nickname
        emailStorage.value = userInfo.email
        userIdStorage.value = userInfo.id
    }
    
    func processRefreshAccessToken(data: Data) {
        let decoder = JSONDecoder()
        let accessToken = try! decoder.decode(AccessToken.self, from: data)
        accessTokenStorage.value = accessToken.access
    }
    
    func processLogout() {
        accessTokenStorage.value = nil
        refreshTokenStorage.value = nil
        userIdStorage.value = nil
        nicknameStorage.value = nil
        emailStorage.value = nil
    }
    
}
