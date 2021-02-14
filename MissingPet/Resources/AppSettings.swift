//
//  AppSettings.swift
//  MissingPet
//
//  Created by Михаил Еремеев on 26.12.2020.
//

import Foundation

class AppSettings {
    
    private static let currentUserIdStorage = UserDefaultsAccessor<Int>.init(key: Constants.userIdKey)
    
    static var currentUserId: Int? {
        return currentUserIdStorage.value
    }
    
    static var isAuthorized: Bool {
        return currentUserIdStorage.value != nil
    }
    
}
