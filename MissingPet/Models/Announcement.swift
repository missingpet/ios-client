//
//  Announcement.swift
//  MissingPet
//
//  Created by Михаил Еремеев on 04.11.2020.
//

import Foundation

struct Announcement {
    
    let id: Int
    let user: String
    let description: String
    let photo: String
    let announcement_type: AnnouncementType
    let animal_type: AnimalType
    let place: String
    let latitude: Double
    let longitude: Double
    let contact_phone_number: String
    let created_at: String
    let updated_at: String
    
    enum AnnouncementType: Int {
        case lost = 1
        case found
    }
    
    enum AnimalType: Int {
        case dog = 1
        case cat
        case other
    }
    
}
