//
//  Router.swift
//  MissingPet
//
//  Created by Михаил Еремеев on 18.10.2020.
//

import Foundation
import Alamofire

enum Router: URLConvertible {

    static let domain = "https://missingpet.social/"
    static let apiPath = domain + "api/"

    // authorization
    case register
    case login

    // announcements
    case listOrCreateAnnouncement
    case feedAnnouncements(userId: Int)
    case detailOrDeleteAnnouncement(id: Int)
    case myAnnouncements(userId: Int)
    case allAnnouncementsMap
    case feedAnnouncementsMap(userId: Int)

    private var _path: String {
        switch self {
        case .register: return "auth/register/"
        case .login: return "auth/login/"
        case .listOrCreateAnnouncement: return "announcement/"
        case .feedAnnouncements(let userId): return "user/\(userId)/feed/"
        case .detailOrDeleteAnnouncement(let id): return "announcement/\(id)/"
        case .myAnnouncements(let userId): return "user/\(userId)/announcements/"
        case .allAnnouncementsMap: return "map/"
        case .feedAnnouncementsMap(let userId): return "user/\(userId)/map/"
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
