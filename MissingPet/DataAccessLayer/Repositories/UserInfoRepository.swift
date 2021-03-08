//
//  UserInfoRepository.swift
//  MissingPet
//
//  Created by Mikhail Eremeev on 05.03.2021.
//

import Foundation

class UserInfoRepository: UserInfoRepositoryType {
    
    private let currentUserIdStorage = UserDefaultsAccessor<Int>(key: Constants.userIdKey)
    private let currentUserNicknameStorage = UserDefaultsAccessor<String>(key: Constants.nicknameKey)
    private let currentUserEmailStorage = UserDefaultsAccessor<String>(key: Constants.emailKey)
    
    func getUserEmail(onSuccess: ((String) -> Void)?,
                      onFailure: ((String) -> Void)?) {
        if let email = self.currentUserEmailStorage.value {
            onSuccess?(email)
        } else {
            onFailure?("An error occurred when getting an email address")
        }
    }
    
    func getUserNickname(onSuccess: ((String) -> Void)?,
                         onFailure: ((String) -> Void)?) {
        if let nickname = self.currentUserNicknameStorage.value {
            onSuccess?(nickname)
        } else {
            onFailure?("An error occurred when getting a nickname")
        }
    }
    
    func getUserId(onSuccess: ((Int) -> Void)?,
                   onFailure: ((String) -> Void)?) {
        if let userId = self.currentUserIdStorage.value {
            onSuccess?(userId)
        } else {
            onFailure?("An error occurred when getting a user id")
        }
    }
    
}
