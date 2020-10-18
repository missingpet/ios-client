//
//  Router.swift
//  MissingPet
//
//  Created by Михаил Еремеев on 18.10.2020.
//

import Foundation
import Alamofire

enum Router: URLConvertible {
    
    static let domain = ""
    static let apiPath = domain + "api/"
    
    // auth
    case signUp
    case logIn
    case logOut
    case refreshToken
    
    // announcement
    case getAllAnnouncements
    case createAnnouncement
    case deleteAnnouncement(announcementId: Int)
    
    private var _path: String {
        switch self {
        case .signUp: return "auth/signup/"
        case .logIn: return "auth/login/"
        case .logOut: return "auth/logout/"
        case .refreshToken: return "auth/refresh-token/"
        case .getAllAnnouncements: return "announcement/all/"
        case .createAnnouncement: return "announcement/create/"
        case .deleteAnnouncement(let announcementId): return "announcement/delete/\(announcementId)/"
        }
    }
    
    var path: String {
        return Router.apiPath + _path
    }
    
    func asURL() throws -> URL {
        let url = URL(string: path)!
        return url
    }
    
}
