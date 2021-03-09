//
//  Constants.swift
//  MissingPet
//
//  Created by Михаил Еремеев on 26.12.2020.
//

import Foundation

struct Constants {

    // MARK:- UserDefaults Keys

    static let accessTokenKey = "access"
    static let nicknameKey = "nickname"
    static let emailKey = "email"
    static let userIdKey = "user_id"

    // MARK:- NotificationCenter Names

    static let userLoggedIn = "UserLoggedIn"
    static let userLoggedOut = "UserLoggedOut"
    static let addressSelected  = "AddressSelected"
    static let announcementCreated = "AnnouncementCreated"
    static let announcementDeleted = "AnnouncementDeleted"

    // MARK:- JSON error fields
    static let nonFieldErrorsErrorKey = "non_field_errors"
    static let photoErrorKey = "photo"
    static let descriptionErrorKey = "description"
    static let addressErrorKey = "address"
    static let latitudeErrorKey = "latitude"
    static let longitudeErrorKey = "longitude"
    static let contactPhoneNumberErrorKey = "contact_phone_number"
    static let emailErrorMessageKey = "email"
    static let nicknameErrorMessageKey = "nickname"
    static let passwordErrorMessageKey = "password"
    static let detailKey = "detail"

}
