//
//  AppSettings.swift
//  MissingPet
//
//  Created by Михаил Еремеев on 26.12.2020.
//

import Foundation

class AppSettings {

    private static let currentUserIdStorage = UserDefaultsAccessor<Int>.init(key: Constants.userIdKey)
    private static let currentUserNicknameStorage = UserDefaultsAccessor<String>.init(key: Constants.nicknameKey)
    private static let currentUserEmailStorage = UserDefaultsAccessor<String>.init(key: Constants.emailKey)

    static var currentUserId: Int? {
        return currentUserIdStorage.value
    }

    static var currentUserNickname: String? {
        return currentUserNicknameStorage.value
    }

    static var currentUserEmail: String? {
        return currentUserEmailStorage.value
    }

    static var isAuthorized: Bool {
        return currentUserIdStorage.value != nil
    }

}
