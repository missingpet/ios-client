//
//  AnnouncementRepositoryType.swift
//  MissingPet
//
//  Created by Михаил Еремеев on 04.11.2020.
//

import UIKit
import Foundation

protocol AnnouncementRepositoryType: class {
    
    func getFeed() -> [Announcement]
    
    func getMyAnnoncements() -> [Announcement]
    
    func createAnnouncement(description: String, photo: UIImage, announcement_type: Int, animal_type: Int, place: String, latitude: Double, longitude: Double, contact_phone_number: String) -> Void
    
    func deleteAnnouncement(id: Int) -> Void
    
}
