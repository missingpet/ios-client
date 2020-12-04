//
//  Announcement.swift
//  MissingPet
//
//  Created by Михаил Еремеев on 04.11.2020.
//

import Foundation

struct Announcement: Codable {
    
    var id: Int
    var user: String
    var description: String
    var photo: String
    var announcement_type: AnnouncementType
    var animal_type: AnimalType
    var place: String
    var latitude: Double
    var longitude: Double
    var contact_phone_number: String
    var created_at: String
    var updated_at: String
    
    enum AnnouncementType: Int, Codable {
        case lost = 1
        case found
    }
    
    enum AnimalType: Int, Codable {
        case dog = 1
        case cat
        case other
    }
    
}
