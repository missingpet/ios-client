//
//  AnnouncementRepository.swift
//  MissingPet
//
//  Created by Михаил Еремеев on 30.11.2020.
//

import UIKit
import Foundation
import Alamofire
import SwiftyJSON

class AnnouncementRepository: AnnouncementRepositoryType {
    
    var feed: [Announcement] = []
    
    var myAnnouncements: [Announcement] = []
    
    func getAllMapInfo() {}
    
    func getFeedMapInfo() {}
    
    func getAllAnnouncements() {}
    
    func getFeed() {}
    
    func getMyAnnoncements() {}
    
    func createAnnouncement(description: String, photo: UIImage, announcementType: Int, animalType: Int, place: String, latitude: Double, longitude: Double, contactPhoneNumber: String) {
    }
    
    func deleteAnnouncement(id: Int) {}
    
}
