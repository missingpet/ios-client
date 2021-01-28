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
    
    // authorization
    case signUp
    case signIn
    case signOut
    case refreshToken
    
    // announcements
    case allAnnouncements
    case feedAnnouncements(userId: Int)
    case createAnnouncement
    case deleteAnnouncement(id: Int)
    case myAnnouncements
    
    private var _path: String {
        switch self {
        case .signUp: return "auth/signup/"
        case .signIn: return "auth/signin/"
        case .signOut: return "auth/signout/"
        case .refreshToken: return "auth/token/refresh/"
        case .allAnnouncements: return "announcement/"
        case .feedAnnouncements(let userId): return "user/\(userId)/feed/"
        case .createAnnouncement: return "announcement/create/"
        case .deleteAnnouncement(let id): return "announcement/delete/\(id)/"
        case .myAnnouncements: return "announcement/my/"
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
