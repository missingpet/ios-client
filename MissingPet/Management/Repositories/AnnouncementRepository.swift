//
//  AnnouncementRepository.swift
//  MissingPet
//
//  Created by Михаил Еремеев on 30.11.2020.
//

import UIKit
import Foundation
import Alamofire

class AnnouncementRepository: AnnouncementRepositoryType {
    
    
    private let userIdStorage = UserDefaultsAccessor<Int>.init(key: Constants.userIdKey)
    
    func getFeed(pageNumber: Int, pageSize: Int, completion: @escaping ([AnnouncementItem]) -> Void) {
        let parameters: [String: Int] = [
            "page": pageNumber,
            "page_size": pageSize,
        ]
        let userId = userIdStorage.value
        let route = userId == nil ? Router.listOrCreateAnnouncement : Router.feedAnnouncements(userId: userId!)
        AF.request(route, method: .get, parameters: parameters)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: Announcements.self, completionHandler: { response in
            if let results = response.value?.results {
                completion(results)
            }
        })
    }
    
    func getMyAnnoncements(completion: @escaping ([AnnouncementItem]) -> Void) {

    }

    func getAnnouncementsMap(completion: @escaping ([AnnouncmenetsMapItem]) -> Void) {

    }
    func createAnnouncement(description: String,
                            photo: UIImage,
                            announcementType: AnnouncementType,
                            animalType: AnimalType,
                            place: String,
                            latitude: Double,
                            longitude: Double,
                            contactPhoneNumber: String,
                            completion: @escaping () -> Void) {


    }

    func deleteAnnouncement(id: Int, completion: @escaping () -> Void) {

    }
    
}

fileprivate extension AnnouncementRepository {
    
    struct Announcements: Decodable {
        let count: Int
        let results: [AnnouncementItem]
    }
    
}
