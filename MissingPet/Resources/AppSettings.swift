//
//  AppSettings.swift
//  MissingPet
//
//  Created by Михаил Еремеев on 26.12.2020.
//

import Foundation

class AppSettings {

    private static let accessTokenStorage = UserDefaultsAccessor<String>(key: Constants.accessTokenKey)

    static var isAuthorized: Bool {
        return accessTokenStorage.value != nil
    }

}
