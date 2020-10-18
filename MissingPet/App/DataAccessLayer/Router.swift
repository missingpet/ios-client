//
//  Router.swift
//  MissingPet
//
//  Created by Михаил Еремеев on 18.10.2020.
//

import Foundation

enum Router: String {
    
    static let domain = ""
    static let apiPath = domain + "api/"
    
    case signUp = "auth/signup/"
    case logIn = "auth/login/"
    case logOut = "auth/logout/"
    case refresh = "auth/refresh-token/"
    
    case getAllAnnouncements = "announcement/all/"
    
    var path: String {
        return rawValue
    }
    
}
