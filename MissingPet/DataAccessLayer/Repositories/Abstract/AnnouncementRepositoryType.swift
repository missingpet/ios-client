//
//  AnnouncementRepositoryType.swift
//  MissingPet
//
//  Created by Михаил Еремеев on 04.11.2020.
//

import UIKit
import Foundation

protocol AnnouncementRepositoryType: class {
    
    var feed: [Announcement] { get }
    
    var myAnnouncements: [Announcement] { get }
    
    func getAllAnnouncements()
    
    func getFeed()
    
    func getMyAnnoncements()
    
    func getAllMapInfo()
    
    func getFeedMapInfo()
    
    func createAnnouncement(description: String, photo: UIImage, announcementType: Int, animalType: Int, place: String, latitude: Double, longitude: Double, contactPhoneNumber: String)
    
    func deleteAnnouncement(id: Int)
    
}
