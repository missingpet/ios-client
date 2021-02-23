//
//  Constants.swift
//  MissingPet
//
//  Created by Михаил Еремеев on 26.12.2020.
//

import Foundation

struct Constants {
    
    // MARK:- UserDefaults Keys
    
    static let refreshTokenKey = "refresh"
    static let accessTokenKey = "access"
    static let nicknameKey = "nickname"
    static let emailKey = "email"
    static let userIdKey = "user_id"

    // MARK:- NotificationCenter Names
    
    static let userLoggedIn = "UserLoggedIn"
    static let userLoggedOut = "UserLoggedOut"
    static let refreshedAccessToken = "RefreshedAccessToken"
    
}
