//
//  AnnouncementRepositoryType.swift
//  MissingPet
//
//  Created by Михаил Еремеев on 04.11.2020.
//

import UIKit
import Foundation

protocol AnnouncementRepositoryType: class {
    
    func getAllAnnouncements()
    
    func getFeed()
    
    func getMyAnnoncements()
    
    func getAllMapInfo()
    
    func getFeedMapInfo()
    
    func createAnnouncement(description: String, photo: UIImage, announcement_type: Int, animal_type: Int, place: String, latitude: Double, longitude: Double, contact_phone_number: String)
    
    func deleteAnnouncement(id: Int)
    
}
