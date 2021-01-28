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
    
    private let usernameStorage = UserDefaultsAccessor<String>(key: Constants.usernameKey)
    private let emailStorage = UserDefaultsAccessor<String>(key: Constants.emailKey)
    private let userIdStorage = UserDefaultsAccessor<Int>(key: Constants.userIdKey)
    
    // MARK: - API Requests
    
    func signIn(email: String,
                password: String,
                completion: @escaping (Bool) -> Void) {
        
        let parameters: [String: String] = [
            "email": email,
            "password": password
        ]
        
        AF.request(Router.signIn, method: .post, parameters: parameters).response(completionHandler: { (dataResponse) in
            let statusCode = dataResponse.response?.statusCode
            if statusCode == 200 {
                let data = dataResponse.data!
                self.processSignIn(data: data)
                completion(true)
            } else {
                completion(false)
            }
        })
    }
    
    func signUp(username: String,
                email: String,
                password: String,
                completion: @escaping (Bool) -> Void) {
        
        let parameters: [String: String] = [
            "email": email,
            "username": username,
            "password": password
        ]
        
        AF.request(Router.signUp, method: .post, parameters: parameters).response(completionHandler: { (dataResponse) in
            let statusCode = dataResponse.response?.statusCode
            if statusCode == 201 {
                completion(true)
            } else {
                completion(false)
            }
        })
        
    }
    
    func signOut(completion: @escaping (Bool) -> Void) {
        
        let refreshToken = refreshTokenStorage.value!
        
        let parameters: [String: String] = [
            "refresh": refreshToken
        ]
        
        AF.request(Router.signOut, method: .post, parameters: parameters).response(completionHandler: { (dataResponse) in
            let statusCode = dataResponse.response?.statusCode
            if statusCode == 204 || statusCode == 400 {
                self.processSignOut()
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
        
        AF.request(Router.refreshToken, method: .post, parameters: parameters).response(completionHandler: { (dataResponse) in
            let statusCode = dataResponse.response?.statusCode
            if statusCode == 200 {
                let data = dataResponse.data!
                self.processRefreshAccessToken(data: data)
                completion(true)
            } else {
                completion(false)
            }
        })
        
    }
    
}

fileprivate extension AuthorizationRepository {
    
    // MARK: - Decodable Structs
    
    struct UserInfo: Decodable {
        
        struct Tokens: Decodable {
            let access: String
            let refresh: String
        }
        
        let id: Int
        let username: String
        let email: String
        let tokens: Tokens
        
    }
    
    struct AccessToken: Decodable {
        let access: String
    }
    
    // MARK: - Data Processing
    
    func processSignIn(data: Data) {
        
        let decoder = JSONDecoder()
        let userInfo: UserInfo = try! decoder.decode(UserInfo.self, from: data)
        
        accessTokenStorage.value = userInfo.tokens.access
        refreshTokenStorage.value = userInfo.tokens.refresh
        usernameStorage.value = userInfo.username
        emailStorage.value = userInfo.email
        userIdStorage.value = userInfo.id
    }
    
    func processSignOut() {
        accessTokenStorage.value = nil
        refreshTokenStorage.value = nil
        usernameStorage.value = nil
        emailStorage.value = nil
        userIdStorage.value = nil
    }
    
    func processRefreshAccessToken(data: Data) {
        let decoder = JSONDecoder()
        let accessToken: AccessToken = try! decoder.decode(AccessToken.self, from: data)
        accessTokenStorage.value = accessToken.access
    }
    
}
