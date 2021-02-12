//
//  AnnouncementRepositoryType.swift
//  MissingPet
//
//  Created by Михаил Еремеев on 04.11.2020.
//

import UIKit
import Foundation

protocol AnnouncementRepositoryType: class {
    
    func getFeed(pageNumber: Int, pageSize: Int, completion: @escaping ([AnnouncementItem]) -> Void)
    
    func getMyAnnoncements(completion: @escaping ([AnnouncementItem]) -> Void)
    
    func getAnnouncementsMap(completion: @escaping ([AnnouncmenetsMapItem]) -> Void)
    
    func createAnnouncement(description: String,
                            photo: UIImage,
                            announcementType: AnnouncementType,
                            animalType: AnimalType,
                            place: String,
                            latitude: Double,
                            longitude: Double,
                            contactPhoneNumber: String,
                            completion: @escaping () -> Void)
    
    func deleteAnnouncement(id: Int, completion: @escaping () -> Void)
    
}
