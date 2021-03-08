//
//  AnnouncementItem.swift
//  MissingPet
//
//  Created by Михаил Еремеев on 04.11.2020.
//

import Foundation
import SwiftyJSON

class AnnouncementItem {

    class User {
        var nickname: String = ""
        var id: Int = 0
    }

    var id: Int = 0
    var user: User = User()
    var description: String = ""
    var photo: String = ""
    var announcementType: AnnouncementType = .lost
    var animalType: AnimalType = .dog
    var address: String = ""
    var latitude: Double = 0.0
    var longitude: Double = 0.0
    var contactPhoneNumber: String = String()
    var createdAt: Date = Date()
    var updatedAt: Date = Date()

}

extension AnnouncementItem {
    
    static func from(json: JSON) -> AnnouncementItem {
        
        let announcementItem = AnnouncementItem()
        
        if let id = json["id"].int {
            announcementItem.id = id
        }
        if let userId = json["user"]["id"].int {
            announcementItem.user.id = userId
        }
        if let userNickname = json["user"]["nickname"].string {
            announcementItem.user.nickname = userNickname
        }
        if let description = json["description"].string {
            announcementItem.description = description
        }
        if let photo = json["photo"].string {
            announcementItem.photo = photo
        }
        if let announcementTypeRawValue = json["announcement_type"].int {
            announcementItem.announcementType = AnnouncementType(rawValue: announcementTypeRawValue) ?? AnnouncementType.lost
        }
        if let animalTypeRawValue = json["animal_type"].int {
            announcementItem.animalType = AnimalType(rawValue: animalTypeRawValue) ?? AnimalType.dog
        }
        if let address = json["address"].string {
            announcementItem.address = address
        }
        if let latitude = json["latitude"].double {
            announcementItem.latitude = latitude
        }
        if let longitude = json["longitude"].double {
            announcementItem.longitude = longitude
        }
        if let contactPhoneNumber = json["contact_phone_number"].string {
            announcementItem.contactPhoneNumber = contactPhoneNumber
        }
        if let createdAt = json["created_at"].date {
            announcementItem.createdAt = createdAt
        }
        if let updatedAt = json["updated_at"].date {
            announcementItem.updatedAt = updatedAt
        }
        
        return announcementItem
    }
    
}
