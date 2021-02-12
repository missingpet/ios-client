//
//  Router.swift
//  MissingPet
//
//  Created by Михаил Еремеев on 18.10.2020.
//

import Foundation
import Alamofire

enum Router: URLConvertible {
    
    static let domain = "http://192.168.0.110/"
    static let apiPath = domain + "api/"
    
    // authorization
    case register
    case login
    case tokenRefresh
    
    // announcements
    case listOrCreateAnnouncement
    case feedAnnouncements(userId: Int)
    case deleteAnnouncement(id: Int)
    case myAnnouncements
    
    private var _path: String {
        switch self {
        case .register: return "auth/register/"
        case .login: return "auth/login/"
        case .tokenRefresh: return "auth/token/refresh/"
        case .listOrCreateAnnouncement: return "announcement/"
        case .feedAnnouncements(let userId): return "user/\(userId)/feed/"
        case .deleteAnnouncement(let id): return "announcement/\(id)/"
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
