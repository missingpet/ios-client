//
//  AnnouncementRepositoryType.swift
//  MissingPet
//
//  Created by Михаил Еремеев on 04.11.2020.
//

import UIKit
import Foundation

protocol AnnouncementRepositoryType: class {
    
    func getFeed(page: Int, completion: @escaping ([AnnouncementItem]) -> Void)
    
    func getAllAnnouncements(page: Int,
                             onStart: @escaping () -> Void,
                             onProcess: @escaping ([AnnouncementItem]) -> Void,
                             onComplete: @escaping () -> Void)
    
    func getMyAnnoncements(completion: @escaping ([AnnouncementItem]) -> Void)
    
    func getFeedMapInfo(completion: @escaping ([AnnouncmenetsMapItem]) -> Void)
    
    func getAllMapInfo(completion: @escaping ([AnnouncmenetsMapItem]) -> Void)
    
    func createAnnouncement(description: String,
                            photo: UIImage,
                            announcementType: AnnouncementType,
                            animalType: AnimalType,
                            place: String,
                            latitude: Double,
                            longitude: Double,
                            contactPhoneNumber: String,
                            completion: @escaping (Bool) -> Void)
    
    func deleteAnnouncement(id: Int, completion: @escaping (Bool) -> Void)
    
}
