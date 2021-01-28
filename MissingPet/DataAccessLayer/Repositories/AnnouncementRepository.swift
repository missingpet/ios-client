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
    
    func getFeed(page: Int, completion: @escaping ([AnnouncementItem]) -> Void) {
        
    }
    
    func getAllAnnouncements(page: Int,
                             onStart: @escaping () -> Void,
                             onProcess: @escaping ([AnnouncementItem]) -> Void,
                             onComplete: @escaping () -> Void) {
        #if DEBUG
        print("AnnouncmenetRepository getAllAnnouncements method called")
        #endif
        let parameters: [String: Any] = [
            "page": page
        ]
        AF.request(Router.allAnnouncements, method: .get, parameters: parameters).validate(statusCode: 200..<300).responseDecodable(of: Announcements.self, completionHandler: { (dataResponse) in
            onStart()
            if let results = dataResponse.value?.results {
                onProcess(results)
            }
            onComplete()
        })
    }
    
    func getMyAnnoncements(completion: @escaping ([AnnouncementItem]) -> Void) {
        
    }
    
    func getFeedMapInfo(completion: @escaping ([AnnouncmenetsMapItem]) -> Void) {
        
    }
    
    func getAllMapInfo(completion: @escaping ([AnnouncmenetsMapItem]) -> Void) {
        
    }
    
    func createAnnouncement(description: String,
                            photo: UIImage,
                            announcementType: AnnouncementType,
                            animalType: AnimalType,
                            place: String,
                            latitude: Double,
                            longitude: Double,
                            contactPhoneNumber: String,
                            completion: @escaping (Bool) -> Void) {
        
        
    }
    
    func deleteAnnouncement(id: Int, completion: @escaping (Bool) -> Void) {
        
    }
    
}

fileprivate extension AnnouncementRepository {
    
    struct Announcements: Decodable {
        let results: [AnnouncementItem]
    }
    
}
